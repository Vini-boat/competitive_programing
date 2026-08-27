<#
.SYNOPSIS
    Junta todos os docs/00-TODO-*.md num unico docs/TODO.md.

.DESCRIPTION
    Para cada arquivo 00-TODO-*.md de docs/, remove o front matter YAML (se houver)
    e concatena o corpo sob um titulo com o nome do arquivo. O arquivo final leva
    o front matter padrao (title/author) uma unica vez, no topo.

    Os caminhos sao resolvidos a partir da localizacao do proprio script,
    entao ele pode ser executado de qualquer diretorio.

.EXAMPLE
    pwsh docs/scripts/generate_todo.ps1
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

# --- Caminhos resolvidos a partir do script, nao do cwd -----------------------
$ScriptDir = $PSScriptRoot
$DocsDir   = Split-Path -Parent $ScriptDir          # .../docs
$OutFile   = Join-Path $DocsDir 'TODO.md'           # .../docs/TODO.md

# --- Front matter padrao, uma vez so no topo ----------------------------------
$FrontMatter = @(
    '---'
    'title: TODO'
    'author: Vinicius de Ávila Bezerra'
    '---'
    ''
)

$FrontMatter + (Get-ChildItem -Path (Join-Path $DocsDir '00-TODO*.md') | ForEach-Object {
    $lines = Get-Content $_.FullName
    if ($lines[0] -eq '---') {
        $endIdx = ($lines | Select-Object -Skip 1 | Select-String -Pattern '^---$' | Select-Object -First 1).LineNumber
        if ($endIdx) {
            $lines = $lines[($endIdx + 1)..($lines.Count - 1)]
        }
    }
    "# $($_.BaseName)"
    ""
    $lines
    ""
}) | Set-Content $OutFile
