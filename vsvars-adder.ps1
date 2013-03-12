# Make my powershell have all the dev tools like Visual Studio Command Prompt.
# Modified from http://blogs.msdn.com/ploeh/archive/2008/04/09/VisualStudio2008PowerShell.aspx

function VsVars32([string]$vscomntools_dir)
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
}
function VS2008() 
{ 
	# The env: vars are added by the VS installers.
	VsVars32($env:VS90COMNTOOLS) 
	"Visual Studio 2008 tools have been added to your path."
}
function VS2005() 
{ 
	VsVars32($env:VS80COMNTOOLS) 
	"Visual Studio 2005 tools have been added to your path."
}
function VS2010()
{
	VsVars32($env:VS100COMNTOOLS)
	"Visual Studio 2010 tools have been added to your path."
}
function VS2012()
{
	VsVars32($env:VS110COMNTOOLS)
	"Visual Studio 2012 tools have been added to your path."
}