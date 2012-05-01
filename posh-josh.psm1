####################################################################################################################
#
# Posh-josh is a Powershell module.  To use it:
#
# 1. Place this file and it's siblings in a subfolder of your Modules folder named 'posh-josh'.  Like so:
#		~\Documents\WindowsPowerShell\Modules\posh-josh
# 2. Add and import statement to your PowerShell profile script, like so:
#		Import-Module posh-josh
#
# TODO: Make rm-orig faster by excluding bin, obj, and other directories.  Perhaps scrape this info from .hgignore?
# TODO: Check for favorite-text-editor to be defined, and ask user to define it if not.
####################################################################################################################

$posh_josh_dir = Split-Path -parent $MyInvocation.MyCommand.Definition

# Make my powershell have all the dev tools like Visual Studio Command Prompt.
. "$posh_josh_dir\vsvars-adder.ps1"

# Add zip and unzip commands
. "$posh_josh_dir\zip-commands.ps1"

# Add beyond compare registration methods
. "$posh_josh_dir\register-beyondcompare.ps1"

# A decent wget implementation.
. "$posh_josh_dir\Get-WebFile.ps1"

# My own handy method for spinning up a .Net mercurial repo with standard ignores for .Net.
function hg-init {
	echo "Copying posh-josh\standard.hgignore -> .\.hgignore"
	cp $psScriptRoot\Standard.hgignore .hgignore
	echo "Creating repo."
	hg init
	hg add .hgignore
}

function git-init {
	echo "Copying posh-josh\standard.gitignore -> .\.gitignore"
	cp $psScriptRoot\Standard.gitignore .gitignore
	echo "Creating repo."
	git init
	#git add -A
}

# Adds all files currently tracked by svn.
function hg-add-from-svn {
	# List all files (filter out directories) tracked by svn, and hg add them.
	# Running this twice will just give a lot of hg 'already tracked!' errors.
	svn ls -R | Where-Object { !$_.EndsWith("/") } | %{ hg add $_ }
}

# Creates a Mercurial repo in the current folder, and adds any files that are tracked by svn.
function hg-init-from-svn {
	hg-init
	hg-add-from-svn
	echo "Done."
	echo "To undo this operation, you can simply delete the .hg directory that was just created."
}

function hg-commit-svn-update {
	hg commit --message "Svn update."
}

function hg-pull-svn-and-commit {
	$hgstat = hg stat
	$svnstat = svn stat  --ignore-externals
	
	# Both should be empty, else abort.
	$result = compare-object $hgstat $svnstat
	
	" This function is not ready yet."
	return
	
	svn update
	hg addremove
	hg-commit-svn-update
}

function svn-stat {
	svn stat --ignore-externals
}

# Handy function for cleaning up all the .orig files mercurial leaves around.
# TODO: Make rm-orig faster by excluding bin, obj, and other directories.  Perhaps scrape this info from .hgignore?
function rm-orig { ls -r -i *.orig | rm }

# Allows you to pipe a set of files in and have them all open up.
function open-text {
	param([string]$file)
	BEGIN {
		open-text-inner $file
	}
	PROCESS {
		# BUG: Sometimes $_ is the full path, sometimes not.  For example, ls C:\Windows\System32\drivers\etc\ | open-text does
		# not produce full paths.
		open-text-inner $_ $_.extension
	}
}

function open-text-inner {
	param([string]$filename, [string]$ext)
	
	if ( $filename ) {
	
		# An attempt to create a single way to load any file into my favorite editor for that file.
		if ($ext -eq '.cs') {
			favorite-text-editor $filename
		}
		
		favorite-text-editor $filename
	}
	else {
		# Just open an empty instance
		favorite-text-editor
	}
}

function svn-diff {
	# Would be nice to turn this into a powershell script instead of a batch file...
	svn diff --diff-cmd "$posh_josh_dir\diff-override.bat"
}

# Copied from posh-git
function Get-LocalOrParentPath($path) {
   $checkIn = Get-Item .
   while ($checkIn -ne $NULL) {
       $pathToTest = [System.IO.Path]::Combine($checkIn.fullname, $path)
       if (Test-Path $pathToTest) {
           return $pathToTest
       } else {
           $checkIn = $checkIn.parent
       }
   }
   return $null
}