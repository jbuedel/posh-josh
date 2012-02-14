$__GlobalSharpZipLibLoaded = $false

function ZipFiles()
{
	Param( [string] $sourcePath, [string] $zipFilename)
	
	if ( $__GlobalSharpZipLibLoaded -eq $false)
	{
		# Reference the SharpZipLib assembly here
		#[System.Reflection.Assembly]::LoadFrom("$profile\.\..\posh-josh\ICSharpCode.SharpZipLib.dll")
		Add-Type -Path "$profile\.\..\posh-josh\ICSharpCode.SharpZipLib.dll"
		$__GlobalSharpZipLibLoaded = $true
	}
	
	# Otherwise it seems to think the current dir is the user dir or something.
	# Note: Resolve-Path errors if path doesn't exist.
	$sourcePath = [IO.Path]::GetFullPath($sourcePath)
	$zipFilename = [IO.Path]::GetFullPath($zipFilename)
	
	$zip = New-Object ICSharpCode.SharpZipLib.Zip.FastZip
	$zip.CreateZip($zipFilename,$sourcePath, $true,"")
} 

function UnzipFiles()
{ 
	Param( [string] $zipFilename, [string] $destinationPath = ".")
	
	if ( $__GlobalSharpZipLibLoaded -eq $false)
	{
		# Reference the SharpZipLib assembly here
		Add-Type -Path "$profile\.\..\posh-josh\ICSharpCode.SharpZipLib.dll"
		$__GlobalSharpZipLibLoaded = $true		
	}
	
	# Otherwise it seems to think the current dir is the user dir or something.
	# Note: Resolve-Path errors if path doesn't exist.
	$zipFilename = [IO.Path]::GetFullPath($zipFilename)
	$destinationPath = [IO.Path]::GetFullPath($destinationPath)
	
	write-host "Zip file: " $zipFilename
	write-host "Destination: " $destinationPath
	
	$zip = New-Object ICSharpCode.SharpZipLib.Zip.FastZip
	$zip.ExtractZip($zipFilename,$destinationPath,"")
}

New-Alias zip ZipFiles
New-Alias unzip UnzipFiles