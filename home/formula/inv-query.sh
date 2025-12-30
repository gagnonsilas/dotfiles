([[ $1 = "-r" ]] && (curl -H "Authorization: Token $(cat ~/.secrets/fsae-inventree.txt)" "http://docker.goatfastracing.com:10003/api/part/" | jq -r '.[] | select(.IPN != "") | .IPN + "   " + .name' > ~/.cache/fsae/inv-new.txt) && mv ~/.cache/fsae/inv-new.txt ~/.cache/fsae/inv.txt && notify-send "Inventory Updated")& 

IPN=$(cat ~/.cache/fsae/inv.txt | rofi -dmenu -i -matching-negate-char '\0' | sed 's/ .*//')

[[ ! -z "$IPN" ]] && firefox "http://docker.goatfastracing.com:10003/part/$IPN/"
