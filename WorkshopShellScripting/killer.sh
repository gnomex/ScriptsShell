killall -u $(who | cut -f1 -d" " | sort | uniq -D)
