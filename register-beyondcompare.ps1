function git-registerbeyondcompare {
	if(get-alias bc) {

		# git difftool 
		git config --global diff.tool bc3
        # TODO: Use bcompare.exe instead of bcomp.exe.  So --dir-diff works properly.
		(get-alias bc ) | %{ git config --global difftool.bc3.path $_.Definition}

		# git 3 way merge
		git config --global merge.tool bc3
		(get-alias bc ) | %{ git config --global mergetool.bc3.path $_.Definition}
		
		# And turn off that annoying prompting.
		git config --global difftool.prompt false

		write-host "Beyond Compare has been registered in git for the diff and difftool commands."
	}
	else {
		write-host "The alias 'bc' needs to exist, and point to bcomp.exe."
		write-host "Do that like so: set-alias 'c:\Program Files (x86)\Beyond Compare 3\bcomp.exe'"
		write-host "Then return this command."
	}
}

function hg-registerbeyondcompare {
# Add this to ~\.hgrc
#[extensions]
#extdiff = 
#
#[extdiff]
#cmd.bcomp = c:/program files (x86)/beyond compare 3/bcomp.exe
#opts.bcomp = /ro

}


git-registerbeyondcompare
