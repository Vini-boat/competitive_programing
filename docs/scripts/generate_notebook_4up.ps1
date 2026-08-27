<#
.SYNOPSIS
    Gera PDFs com varias paginas por folha A4, para imprimir menos papel.

.DESCRIPTION
    Script SEPARADO do generate_notebook.ps1: nao altera nada dele e escreve
    num diretorio proprio (docs/pdf-4up/). Dois modos:

      -Mode native  (padrao)
          Gera o PDF direto no tamanho da celula (A6 para 2x2, A5 para 2x1) e
          so entao monta a folha A4. A escala fica 1:1, ou seja, a fonte sai do
          tamanho que voce pediu e as margens sao exatamente -Margin. Nada
          encolhe.

      -Mode shrink
          Pega os PDFs A4 ja existentes em docs/pdf/ e apenas encolhe 2x2 na
          folha (escala 0,707). Nao regera nada, mas o texto fica pequeno e as
          margens de 2,5cm do Eisvogel viram ~1,8cm de papel branco em cada
          borda interna. Use -Trim para cortar essas margens.

    A montagem N-up usa pdfpages + lualatex, com delta 0 por padrao: o espaco
    entre as paginas na folha e zero, todo o branco que sobrar vem da margem
    de dentro de cada pagina.

.PARAMETER Nup
    '2x2' (4 paginas por folha A4 retrato, celula A6) ou
    '2x1' (2 paginas por folha A4 paisagem, celula A5).

.PARAMETER Filter
    Wildcard opcional (ex: -Filter 'Sliding*').

.PARAMETER Exclude
    Wildcards para PULAR (ex: -Exclude '00-TODO-*').

.PARAMETER Margin
    Margem de cada pagina no modo native. Padrao 8mm.

.PARAMETER FontSize
    Corpo do texto no modo native. Padrao 9pt.

.PARAMETER CodeFontSize
    Tamanho dos blocos de codigo no modo native. Padrao \footnotesize.

.PARAMETER Delta
    Espaco entre as celulas na folha. Padrao '0mm 0mm'.

.PARAMETER Frame
    Desenha uma moldura em volta de cada pagina (ajuda na hora de cortar).

.PARAMETER Trim
    So no modo shrink: corta as bordas do PDF original antes de montar.
    Formato 'esq baixo dir cima', ex: -Trim '20mm 20mm 20mm 20mm'.

.PARAMETER KeepIntermediate
    Guarda os PDFs intermediarios (A6/A5) em docs/pdf-4up/_src/.

.PARAMETER Clean
    Apaga os PDFs de docs/pdf-4up/ antes de gerar.

.EXAMPLE
    pwsh docs/scripts/generate_notebook_4up.ps1
    pwsh docs/scripts/generate_notebook_4up.ps1 -Exclude '00-TODO-*' -Frame
    pwsh docs/scripts/generate_notebook_4up.ps1 -Nup 2x1 -FontSize 10pt
    pwsh docs/scripts/generate_notebook_4up.ps1 -Mode shrink -Trim '18mm 18mm 18mm 18mm'
#>
[CmdletBinding()]
param(
    [ValidateSet('native','shrink')]
    [string]$Mode = 'native',

    [ValidateSet('2x2','2x1')]
    [string]$Nup = '2x2',

    [string]$Filter = '*.md',
    [string[]]$Exclude = @(),

    [string]$Margin = '8mm',
    [string]$FontSize = '9pt',
    [string]$CodeFontSize = '\footnotesize',

    [string]$Delta = '0mm 0mm',
    [switch]$Frame,

    [string]$Trim = '',

    [switch]$KeepIntermediate,
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'

# --- Caminhos resolvidos a partir do script, nao do cwd -----------------------
$ScriptDir = $PSScriptRoot
$DocsDir   = Split-Path -Parent $ScriptDir          # .../docs
$PdfDir    = Join-Path $DocsDir 'pdf'               # .../docs/pdf  (so leitura)
$OutDir    = Join-Path $DocsDir 'pdf-4up'           # .../docs/pdf-4up
$SrcDir    = Join-Path $OutDir '_src'
$Template  = Join-Path $ScriptDir 'eisvogel.latex'

if (-not (Test-Path -LiteralPath $Template)) {
    throw "Template nao encontrado: $Template"
}

# --- Geometria: a celula do N-up define o tamanho nativo da pagina ------------
# A4 retrato  = 210 x 297mm   -> 2x2 da celulas de 105 x 148,5mm   (A6 retrato)
# A4 paisagem = 297 x 210mm   -> 2x1 da celulas de 148,5 x 210mm   (A5 retrato)
switch ($Nup) {
    '2x2' { $CellPaper = 'a6'; $SheetOpts = 'a4paper';           $PerSheet = 4 }
    '2x1' { $CellPaper = 'a5'; $SheetOpts = 'a4paper,landscape'; $PerSheet = 2 }
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
if ($Mode -eq 'native' -and -not $Pandoc) {
    throw 'pandoc nao encontrado no PATH nem nos caminhos conhecidos.'
}

$MikTexBin = [Environment]::ExpandEnvironmentVariables('%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64')
$Engine = Resolve-Tool -Name 'lualatex' -Fallbacks @( (Join-Path $MikTexBin 'lualatex.exe') )
if (-not $Engine) { throw 'lualatex nao encontrado no PATH nem no MiKTeX.' }

if (Test-Path -LiteralPath $MikTexBin) {
    if (($env:PATH -split ';') -notcontains $MikTexBin) {
        $env:PATH = "$MikTexBin;$env:PATH"
    }
}

# MiKTeX baixa o pdfpages sozinho se ainda nao estiver instalado
$IsMikTex   = $Engine -match 'MiKTeX'
$EngineArgs = @('--interaction=nonstopmode', '--halt-on-error')
if ($IsMikTex) { $EngineArgs += '--enable-installer' }

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
if ($Clean) {
    Get-ChildItem -LiteralPath $OutDir -Filter *.pdf -ErrorAction SilentlyContinue |
        Remove-Item -Force
}
if ($KeepIntermediate) { New-Item -ItemType Directory -Force -Path $SrcDir | Out-Null }

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

Write-Host "modo     : $Mode ($Nup, $PerSheet paginas por folha A4)"
if ($Mode -eq 'native') {
    Write-Host "pandoc   : $Pandoc"
    Write-Host "pagina   : $CellPaper, margem $Margin, corpo $FontSize, codigo $CodeFontSize"
} else {
    Write-Host "origem   : $PdfDir (PDFs A4 existentes, escala 0,707)"
    if ($Trim) { Write-Host "trim     : $Trim" }
}
Write-Host "engine   : $Engine"
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
    $escaped = [regex]::Replace($Arg, '(\\*)"', '$1$1\"')
    $escaped = [regex]::Replace($escaped, '(\\+)$', '$1$1')
    return '"' + $escaped + '"'
}

# --- Detecta se o .md ja tem title no frontmatter YAML ------------------------
function Test-HasYamlTitle {
    param([string]$Path)

    $lines = @(Get-Content -LiteralPath $Path -Encoding utf8 -TotalCount 40)
    if ($lines.Count -eq 0 -or $lines[0].Trim() -ne '---') { return $false }
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -match '^(---|\.\.\.)$') { return $false }
        if ($lines[$i] -match '^\s*title\s*:\s*\S')    { return $true }
    }
    return $false
}

# --- Contagem de paginas ------------------------------------------------------
$PdfInfo = Resolve-Tool -Name 'pdfinfo' -Fallbacks @( (Join-Path $MikTexBin 'pdfinfo.exe') )

function Get-PdfPageCount {
    param([string]$Path)

    if ($PdfInfo) {
        $out  = & $PdfInfo $Path 2>$null
        $line = $out | Where-Object { $_ -match '^Pages:\s+\d+' } | Select-Object -First 1
        if ($line -and $line -match '^Pages:\s+(\d+)') { return [int]$Matches[1] }
    }
    # fallback sem ferramenta externa: conta objetos /Type /Page
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $txt   = [System.Text.Encoding]::Latin1.GetString($bytes)
    return ([regex]::Matches($txt, '/Type\s*/Page[^s]')).Count
}

# --- Executa um processo capturando a saida -----------------------------------
function Invoke-Tool {
    param(
        [string]$FilePath,
        [string[]]$Arguments,
        [string]$WorkingDirectory = $null
    )

    $tmp        = [System.IO.Path]::GetTempPath()
    $stderrFile = Join-Path $tmp ('4up-' + [guid]::NewGuid().ToString('N') + '.log')
    $stdoutFile = Join-Path $tmp ('4up-' + [guid]::NewGuid().ToString('N') + '.out')
    try {
        $quoted = @($Arguments | ForEach-Object { ConvertTo-QuotedArg $_ })
        $sp = @{
            FilePath               = $FilePath
            ArgumentList           = $quoted
            NoNewWindow            = $true
            Wait                   = $true
            PassThru               = $true
            RedirectStandardError  = $stderrFile
            RedirectStandardOutput = $stdoutFile
        }
        if ($WorkingDirectory) { $sp.WorkingDirectory = $WorkingDirectory }
        $proc = Start-Process @sp

        $err = ''
        if (Test-Path -LiteralPath $stderrFile) {
            $err = (Get-Content -LiteralPath $stderrFile -Raw -ErrorAction SilentlyContinue)
        }
        if ($null -eq $err) { $err = '' }

        # o lualatex escreve os erros no stdout, nao no stderr
        if ($proc.ExitCode -ne 0 -and (Test-Path -LiteralPath $stdoutFile)) {
            $out = (Get-Content -LiteralPath $stdoutFile -Raw -ErrorAction SilentlyContinue)
            if ($out) {
                $linhas = ($out -split "\r?\n") | Where-Object { $_ -match '^!|^l\.\d|LaTeX Error|Emergency stop' }
                if ($linhas) { $err = ($err + "`n" + ($linhas -join ' | ')).Trim() }
            }
        }
        return [pscustomobject]@{ Code = $proc.ExitCode; Err = $err }
    }
    catch {
        return [pscustomobject]@{ Code = -1; Err = $_.Exception.Message }
    }
    finally {
        Remove-Item -LiteralPath $stderrFile, $stdoutFile -Force -ErrorAction SilentlyContinue
    }
}

# --- Gera o PDF de origem no tamanho da celula (modo native) ------------------
function New-CellPdf {
    param([System.IO.FileInfo]$Md, [string]$OutPdf)

    $name = [System.IO.Path]::GetFileNameWithoutExtension($Md.Name)

    $pandocArgs = @(
        $Md.FullName
        '-o', $OutPdf
        '--from=markdown+yaml_metadata_block'
        '--template', $Template
        '--syntax-highlighting=idiomatic'
        '--pdf-engine=lualatex'
        '--resource-path', $DocsDir
        # papel do tamanho da celula: no N-up a escala fica 1:1
        '-V', "papersize:$CellPaper"
        '-V', "geometry:${CellPaper}paper"
        '-V', "geometry:margin=$Margin"
        # sem isto o cabecalho/rodape do Eisvogel fica FORA da pagina e sai cortado
        '-V', 'geometry:includehead=true'
        '-V', 'geometry:includefoot=true'
        '-V', "classoption:fontsize=$FontSize"
        '-V', "code-block-font-size:$CodeFontSize"
    )
    if (-not (Test-HasYamlTitle -Path $Md.FullName)) {
        $pandocArgs += @('--metadata', "title=$name")
    }

    return Invoke-Tool -FilePath $Pandoc -Arguments $pandocArgs
}

# --- Monta o N-up na folha A4 -------------------------------------------------
function New-NupPdf {
    param([string]$InPdf, [string]$OutPdf)

    $work = Join-Path ([System.IO.Path]::GetTempPath()) ('4up-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Force -Path $work | Out-Null
    try {
        # copia com nome ASCII e sem espaco: o \includepdf engasga com acento
        $src = Join-Path $work 'src.pdf'
        Copy-Item -LiteralPath $InPdf -Destination $src -Force

        $opts = @('pages=-', "nup=$Nup", "delta=$Delta", 'turn=false')
        if ($Frame) { $opts += 'frame' }
        if ($Trim -and $Mode -eq 'shrink') { $opts += @("trim=$Trim", 'clip') }
        $optStr = $opts -join ','

        $tex = @"
\documentclass{article}
\usepackage[$SheetOpts,margin=0pt]{geometry}
\usepackage{pdfpages}
\pagestyle{empty}
\begin{document}
\includepdf[$optStr]{src.pdf}
\end{document}
"@
        $texPath = Join-Path $work 'nup.tex'
        [System.IO.File]::WriteAllText($texPath, $tex, [System.Text.UTF8Encoding]::new($false))

        $res = Invoke-Tool -FilePath $Engine -Arguments ($EngineArgs + @('nup.tex')) -WorkingDirectory $work

        $built = Join-Path $work 'nup.pdf'
        if ($res.Code -eq 0 -and (Test-Path -LiteralPath $built)) {
            Copy-Item -LiteralPath $built -Destination $OutPdf -Force
        }
        return $res
    }
    finally {
        Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# --- Geracao ------------------------------------------------------------------
$ok     = [System.Collections.Generic.List[object]]::new()
$falhou = [System.Collections.Generic.List[object]]::new()
$idx    = 0

foreach ($f in $Files) {
    $idx++
    $name = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
    $pdf  = Join-Path $OutDir ($name + '.pdf')

    Write-Host ("[{0,2}/{1}] {2}" -f $idx, $Files.Count, $f.Name) -NoNewline

    $tmpSrc  = $null
    $cellPdf = $null
    $res     = $null

    if ($Mode -eq 'native') {
        if ($KeepIntermediate) {
            $cellPdf = Join-Path $SrcDir ($name + '.pdf')
        } else {
            $tmpSrc  = Join-Path ([System.IO.Path]::GetTempPath()) ('cell-' + [guid]::NewGuid().ToString('N') + '.pdf')
            $cellPdf = $tmpSrc
        }
        $res = New-CellPdf -Md $f -OutPdf $cellPdf
        if ($res.Code -ne 0 -or -not (Test-Path -LiteralPath $cellPdf)) {
            $res = [pscustomobject]@{ Code = ($res.Code -ne 0 ? $res.Code : -1); Err = 'pandoc: ' + $res.Err }
        }
    }
    else {
        $cellPdf = Join-Path $PdfDir ($name + '.pdf')
        if (-not (Test-Path -LiteralPath $cellPdf)) {
            $res = [pscustomobject]@{ Code = -1; Err = "PDF de origem nao existe: $cellPdf (rode o generate_notebook.ps1 antes)" }
        } else {
            $res = [pscustomobject]@{ Code = 0; Err = '' }
        }
    }

    $pagOrig = 0
    if ($res.Code -eq 0) {
        $pagOrig = Get-PdfPageCount -Path $cellPdf
        $res     = New-NupPdf -InPdf $cellPdf -OutPdf $pdf
    }
    if ($tmpSrc) { Remove-Item -LiteralPath $tmpSrc -Force -ErrorAction SilentlyContinue }

    $info = if (Test-Path -LiteralPath $pdf) { Get-Item -LiteralPath $pdf } else { $null }

    if ($res.Code -eq 0 -and $info -and $info.Length -gt 0) {
        $folhas = Get-PdfPageCount -Path $pdf
        Write-Host ("  OK  ({0} pag -> {1} folhas)" -f $pagOrig, $folhas) -ForegroundColor Green
        $ok.Add([pscustomobject]@{
            PDF     = $info.Name
            KB      = [math]::Round($info.Length / 1KB, 1)
            Paginas = $pagOrig
            Folhas  = $folhas
        })
        if ($res.Err -match 'Missing character') {
            $glyphs = [regex]::Matches($res.Err, 'There is no (.+?) \(U\+') |
                      ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
            Write-Host ('       aviso: glifo ausente na fonte -> ' + ($glyphs -join ' ')) -ForegroundColor DarkYellow
        }
    }
    else {
        Write-Host '  FALHOU' -ForegroundColor Red
        if ($info -and $info.Length -eq 0) {
            Remove-Item -LiteralPath $pdf -Force -ErrorAction SilentlyContinue
        }
        $msg = (($res.Err -split "\r?\n") | Where-Object { $_ -match '\S' } | Select-Object -Last 6) -join ' | '
        if (-not $msg) { $msg = "processo saiu com codigo $($res.Code)" }
        Write-Host "       $msg" -ForegroundColor DarkRed
        $falhou.Add([pscustomobject]@{ Arquivo = $f.Name; Erro = $msg })
    }
}

# --- Relatorio ---------------------------------------------------------------
Write-Host ''
Write-Host '================ RESUMO ================'

$ok | Format-Table -AutoSize | Out-String -Width 200 | Write-Host

$totalFolhas = ($ok | Measure-Object -Property Folhas  -Sum).Sum
$totalPag    = ($ok | Measure-Object -Property Paginas -Sum).Sum
if (-not $totalFolhas) { $totalFolhas = 0 }
if (-not $totalPag)    { $totalPag    = 0 }

# quantas folhas os PDFs A4 de docs/pdf/ gastariam (1 pagina por folha)
$folhasAtual = 0
foreach ($r in $ok) {
    $orig = Join-Path $PdfDir $r.PDF
    if (Test-Path -LiteralPath $orig) { $folhasAtual += Get-PdfPageCount -Path $orig }
}

Write-Host ("PDFs gerados      : {0}/{1}" -f $ok.Count, $Files.Count)
Write-Host ("PAGINAS           : {0}" -f $totalPag)
Write-Host ("FOLHAS A4         : {0}" -f $totalFolhas) -ForegroundColor Cyan
if ($folhasAtual -gt 0) {
    $econ = $folhasAtual - $totalFolhas
    $pct  = [math]::Round(100 * $econ / $folhasAtual, 1)
    Write-Host ("FOLHAS em docs/pdf: {0}  ->  economia de {1} folhas ({2}%)" -f $folhasAtual, $econ, $pct) -ForegroundColor Cyan
}

if ($falhou.Count -gt 0) {
    Write-Host ''
    Write-Host ("FALHAS ({0}):" -f $falhou.Count) -ForegroundColor Red
    $falhou | Format-Table -AutoSize -Wrap | Out-String -Width 200 | Write-Host
    exit 1
}

Write-Host ''
Write-Host 'Concluido sem falhas.' -ForegroundColor Green
