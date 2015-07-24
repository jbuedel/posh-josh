# Make my powershell have all the dev tools like Visual Studio Command Prompt.
# Modified from http://blogs.msdn.com/ploeh/archive/2008/04/09/VisualStudio2008PowerShell.aspx

function VsVars32([string]$vscomntools_dir, [string]$msg)
{
	if( $Global:VsVars32CurrentSetting -ne $vscomntools_dir ) 
	{
		$batchFile = [System.IO.Path]::Combine($vscomntools_dir, "vsvars32.bat")

		if(!(test-path $batchFile)) {
			echo "$batchFile does not exist."
			return
		}
		
		$cmd = "`"$batchFile`" & set"
		cmd /c $cmd | Foreach-Object {
			$p, $v = $_.split('=')
			Set-Item -path env:$p -value $v
		}
		
		$Global:VsVars32CurrentSetting = $vscomntools_dir
		write-host "`Visual Studio $msg tools have been added to your path."
	}
	#else { write-host "Visual Studio $msg tools already set." }
}
function VS2008() 
{ 
	# The env: vars are added by the VS installers.
	VsVars32 $env:VS90COMNTOOLS "2008"
}
function VS2005() 
{ 
	VsVars32 $env:VS80COMNTOOLS "2005"
}
function VS2010()
{
	VsVars32 $env:VS100COMNTOOLS "2010"
}
function VS2012()
{
	VsVars32 $env:VS110COMNTOOLS "2012"
}
function VS2013() 
{
	VsVars32 $env:VS120COMNTOOLS "2013"
}
function VS2015() 
{
	VsVars32 $env:VS140COMNTOOLS "2015"
}
