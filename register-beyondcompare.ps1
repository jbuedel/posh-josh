function git-registerbeyondcompare {
	# TODO: Find this dynamically.  Possibly use (maybe require?) the bc alias.
	$bcompexe = "c:/program files (x86)/beyond compare 3/bcomp.exe"

	# git difftool 
	git config --global diff.tool bc3
	git config --global difftool.bc3.path $bcompexe

	# git 3 way merge
	git config --global merge.tool bc3
	git config --global mergetool.bc3.path $bcompexe

	write-host "Beyond Compare has been registered in git for the diff and difftool commands."
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