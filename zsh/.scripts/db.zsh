function mkdb { docker run --name postgres -p 5432:5432 -e POSTGRES_DB=postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d --rm docker.io/postgres:alpine -c max_connections=65535 }
function dbsh { docker exec -it postgres psql postgres postgres }

function _srccomp {
	local dirs;
	dirs=();

	ls --color=never --width=1 $HOME/Source | sort | while read line; do
		dirs[$(($#dirs+1))]="$line"
	done

	_describe -t projects "project" dirs
}

compdef _srccomp mkdb
compdef _srccomp dbip
compdef _srccomp dbsh
