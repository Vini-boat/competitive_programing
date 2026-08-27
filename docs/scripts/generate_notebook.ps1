<#
.SYNOPSIS
    Gera um PDF por arquivo .md do caderno de maratona.

.DESCRIPTION
    Le todos os .md em docs/ e gera um PDF individual para cada um em docs/pdf/,
    usando o template Eisvogel (docs/scripts/eisvogel.latex) e o engine lualatex.

    Todos os caminhos sao resolvidos a partir da localizacao do proprio script,
    entao ele pode ser executado de qualquer diretorio.

.PARAMETER Filter
    Wildcard opcional para gerar so um subconjunto (ex: -Filter '00-TODO-*').

.PARAMETER Exclude
    Um ou mais wildcards para PULAR (ex: -Exclude '00-TODO-*').

.PARAMETER Clean
    Apaga os PDFs de docs/pdf/ antes de gerar.

.EXAMPLE
    pwsh docs/scripts/generate_notebook.ps1
    pwsh docs/scripts/generate_notebook.ps1 -Filter '00-TODO-*'
    pwsh docs/scripts/generate_notebook.ps1 -Exclude '00-TODO-*'
#>
[CmdletBinding()]
param(
    [string]$Filter = '*.md',
    [string[]]$Exclude = @(),
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'

# --- Caminhos resolvidos a partir do script, nao do cwd -----------------------
$ScriptDir = $PSScriptRoot
$DocsDir   = Split-Path -Parent $ScriptDir          # .../docs
$OutDir    = Join-Path $DocsDir 'pdf'               # .../docs/pdf
$Template  = Join-Path $ScriptDir 'eisvogel.latex'

if (-not (Test-Path -LiteralPath $Template)) {
    throw "Template nao encontrado: $Template"
}

# --- Localiza pandoc e o engine LaTeX ----------------------------------------
function Resolve-Tool {
    param([string]$Name, [string[]]$Fallbacks)

    $cmd = Get-Command $Name -CommandType Application -ErrorAction SilentlyContinue |
           Select-Object -First 1
    if ($cmd) { return $cmd.Source }
    foreach ($p in $Fallbacks) {
        $expanded = [Environment]::ExpandEnvironmentVariables($p)
        if (Test-Path -LiteralPath $expanded) { return $expanded }
    }
    return $null
}

$Pandoc = Resolve-Tool -Name 'pandoc' -Fallbacks @(
    '%LOCALAPPDATA%\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.10\pandoc.exe',
    '%ProgramFiles%\Pandoc\pandoc.exe'
)
if (-not $Pandoc) { throw 'pandoc nao encontrado no PATH nem nos caminhos conhecidos.' }

$MikTexBin = [Environment]::ExpandEnvironmentVariables('%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64')
$Engine = Resolve-Tool -Name 'lualatex' -Fallbacks @( (Join-Path $MikTexBin 'lualatex.exe') )
if (-not $Engine) { throw 'lualatex nao encontrado no PATH nem no MiKTeX.' }

# Garante que o engine fica visivel para o pandoc mesmo se nao estiver no PATH
if (Test-Path -LiteralPath $MikTexBin) {
    if (($env:PATH -split ';') -notcontains $MikTexBin) {
        $env:PATH = "$MikTexBin;$env:PATH"
    }
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
if ($Clean) {
    Get-ChildItem -LiteralPath $OutDir -Filter *.pdf -ErrorAction SilentlyContinue |
        Remove-Item -Force
}

# --- Coleta os arquivos -------------------------------------------------------
$Files = Get-ChildItem -LiteralPath $DocsDir -Filter $Filter -File |
         Where-Object { $_.Extension -eq '.md' } |
         Where-Object {
             $nome = $_.Name
             -not ($Exclude | Where-Object { $nome -like $_ })
         } |
         Sort-Object Name

if (-not $Files) {
    $msg = "Nenhum .md encontrado em $DocsDir com o filtro '$Filter'"
    if ($Exclude) { $msg += " (excluindo: $($Exclude -join ', '))" }
    throw "$msg."
}

Write-Host "pandoc   : $Pandoc"
Write-Host "engine   : $Engine"
Write-Host "template : $Template"
Write-Host "saida    : $OutDir"
Write-Host "arquivos : $($Files.Count)"
Write-Host ''

# --- Quoting de argumentos -----------------------------------------------------
# Start-Process -ArgumentList NAO cita argumentos automaticamente: sem isto,
# qualquer nome de arquivo com espaco (ex: "Sliding Window.md") vira dois
# argumentos e o pandoc falha com "withBinaryFile: does not exist".
function ConvertTo-QuotedArg {
    param([string]$Arg)

    if ($Arg -notmatch '[\s"]') { return $Arg }
    # dobra as barras invertidas que precedem aspas / fim da string
    $escaped = [regex]::Replace($Arg, '(\\*)"', '$1$1\"')
    $escaped = [regex]::Replace($escaped, '(\\+)$', '$1$1')
    return '"' + $escaped + '"'
}

# --- Detecta se o .md ja tem `title:` no frontmatter YAML --------------------
function Test-HasYamlTitle {
    param([string]$Path)

    $lines = @(Get-Content -LiteralPath $Path -Encoding utf8 -TotalCount 40)
    if ($lines.Count -eq 0 -or $lines[0].Trim() -ne '---') { return $false }
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -match '^(---|\.\.\.)$') { return $false }   # fim do frontmatter
        if ($lines[$i] -match '^\s*title\s*:\s*\S')    { return $true }
    }
    return $false
}

# --- Geracao ------------------------------------------------------------------
$ok     = [System.Collections.Generic.List[object]]::new()
$falhou = [System.Collections.Generic.List[object]]::new()
$idx    = 0

foreach ($f in $Files) {
    $idx++
    $name = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
    $pdf  = Join-Path $OutDir ($name + '.pdf')

    $pandocArgs = @(
        $f.FullName
        '-o', $pdf
        '--from=markdown+yaml_metadata_block'
        '--template', $Template
        '--syntax-highlighting=idiomatic'
        '--pdf-engine=lualatex'
        '--resource-path', $DocsDir
    )
    # Sem title no frontmatter -> usa o nome do arquivo, senao o eisvogel
    # gera um PDF sem titulo de capa.
    if (-not (Test-HasYamlTitle -Path $f.FullName)) {
        $pandocArgs += @('--metadata', "title=$name")
    }

    Write-Host ("[{0,2}/{1}] {2}" -f $idx, $Files.Count, $f.Name) -NoNewline

    $stderrFile = Join-Path ([System.IO.Path]::GetTempPath()) ("pandoc-" + [guid]::NewGuid().ToString('N') + '.log')
    $err  = ''
    $code = -1
    try {
        $quoted = @($pandocArgs | ForEach-Object { ConvertTo-QuotedArg $_ })
        $proc = Start-Process -FilePath $Pandoc -ArgumentList $quoted -NoNewWindow -Wait -PassThru `
                              -RedirectStandardError $stderrFile
        $code = $proc.ExitCode
        if (Test-Path -LiteralPath $stderrFile) {
            $err = (Get-Content -LiteralPath $stderrFile -Raw -ErrorAction SilentlyContinue)
        }
    }
    catch {
        $code = -1
        $err  = $_.Exception.Message
    }
    finally {
        Remove-Item -LiteralPath $stderrFile -Force -ErrorAction SilentlyContinue
    }
    if ($null -eq $err) { $err = '' }

    $info = if (Test-Path -LiteralPath $pdf) { Get-Item -LiteralPath $pdf } else { $null }

    if ($code -eq 0 -and $info -and $info.Length -gt 0) {
        Write-Host ("  OK  ({0:N0} bytes)" -f $info.Length) -ForegroundColor Green
        $ok.Add([pscustomobject]@{ Arquivo = $info.Name; Bytes = $info.Length })
        # Glifos sem cobertura na fonte (emoji) sao apenas informativos
        if ($err -match 'Missing character') {
            $glyphs = [regex]::Matches($err, 'There is no (.+?) \(U\+') |
                      ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
            Write-Host ("       aviso: glifo ausente na fonte -> " + ($glyphs -join ' ')) -ForegroundColor DarkYellow
        }
    }
    else {
        Write-Host '  FALHOU' -ForegroundColor Red
        if ($info -and $info.Length -eq 0) {
            Remove-Item -LiteralPath $pdf -Force -ErrorAction SilentlyContinue
        }
        $msg = (($err -split "`r?`n") | Where-Object { $_ -match '\S' } | Select-Object -Last 6) -join ' | '
        if (-not $msg) { $msg = "pandoc saiu com codigo $code" }
        Write-Host "       $msg" -ForegroundColor DarkRed
        $falhou.Add([pscustomobject]@{ Arquivo = $f.Name; Erro = $msg })
    }
}

# --- Relatorio ---------------------------------------------------------------
Write-Host ''
Write-Host '================ RESUMO ================'

$pdfinfo  = Resolve-Tool -Name 'pdfinfo' -Fallbacks @( (Join-Path $MikTexBin 'pdfinfo.exe') )
$totalPag = 0
$vazios   = 0

$rows = foreach ($r in $ok) {
    $path = Join-Path $OutDir $r.Arquivo
    if ($r.Bytes -eq 0) { $vazios++ }

    $pag = $null
    if ($pdfinfo) {
        $out  = & $pdfinfo $path 2>$null
        $line = $out | Where-Object { $_ -match '^Pages:\s+\d+' } | Select-Object -First 1
        if ($line -and $line -match '^Pages:\s+(\d+)') { $pag = [int]$Matches[1] }
    }
    if ($null -eq $pag) {
        # fallback sem ferramenta externa: conta objetos /Type /Page
        $bytes = [System.IO.File]::ReadAllBytes($path)
        $txt   = [System.Text.Encoding]::Latin1.GetString($bytes)
        $pag   = ([regex]::Matches($txt, '/Type\s*/Page[^s]')).Count
    }
    $totalPag += $pag

    [pscustomobject]@{
        PDF     = $r.Arquivo
        KB      = [math]::Round($r.Bytes / 1KB, 1)
        Paginas = $pag
    }
}

$rows | Format-Table -AutoSize | Out-String -Width 200 | Write-Host

Write-Host ("PDFs gerados     : {0}/{1}" -f $ok.Count, $Files.Count)
Write-Host ("PDFs com 0 byte  : {0}" -f $vazios)
Write-Host ("TOTAL DE PAGINAS : {0}" -f $totalPag) -ForegroundColor Cyan

if ($falhou.Count -gt 0) {
    Write-Host ''
    Write-Host ("FALHAS ({0}):" -f $falhou.Count) -ForegroundColor Red
    $falhou | Format-Table -AutoSize -Wrap | Out-String -Width 200 | Write-Host
    exit 1
}

Write-Host ''
Write-Host 'Concluido sem falhas.' -ForegroundColor Green
