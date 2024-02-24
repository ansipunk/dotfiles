function dumpster { ps aux | grep $1 | awk	"{print \$2}" | xargs kill -9 || true}
function newrepo { git remote add origin git@git.sr.ht:~ansipunk/$1 }
function purge { docker ps -aq | xargs docker stop | xargs docker rm }

function j {
	cd $HOME/Source/$1 2>/dev/null || (echo "no such project: $1" && return 1)
}

function goc {
	PROJECT=git.sr.ht/~ansipunk/$1
	PROJECTPATH=$HOME/Source/$1
	mkdir $PROJECTPATH && cd $PROJECTPATH
	git init && newrepo $1
	go mod init $PROJECT
}

function rebase {
	BRANCH=$(git rev-parse --abbrev-ref HEAD)
	git checkout master
	git pull
	git checkout $BRANCH
	git rebase master
}

function _jcomp {
	local dirs;
	dirs=();

	ls --color=never --width=1 $HOME/Source | sort | while read line; do
		dirs[$(($#dirs+1))]="$line"
	done

	_describe -t projects "project" dirs
}

compdef _jcomp j
