function mkdb { docker run --name $1 -p 5432:5432 -e POSTGRES_DB=$1 -e POSTGRES_USER=$1 -e POSTGRES_PASSWORD=$1 -d --rm docker.io/postgres:alpine -c max_connections=65535 }
function dbip { docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1 }
function dbsh { docker exec -it $1 psql $1 $1 }

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
