
# create index.html (overwrite)
HYGEN_OVERWRITE=1 hygen vocab init
sleep 1
# loop thru params and add html for each
for var in "$@"
do
    echo "$var"
    hygen vocab attributes --attribute $var
done