([[ $1 = "-r" ]] && (curl -H "Authorization: Token $(cat ~/.secrets/agzen-inventree.txt)" "http://inventree.tortoise-chickadee.ts.net/api/part/" | jq -r '.[] | select(.IPN != "") | .IPN + "   " + .name + "   " + .description' > ~/.cache/agzen/inv-new.txt) && mv ~/.cache/agzen/inv-new.txt ~/.cache/agzen/inv.txt && notify-send "Inventory Updated")& 

IPN=$(cat ~/.cache/agzen/inv.txt | rofi -dmenu -i -matching-negate-char '\0' | sed 's/ .*//')

[[ ! -z "$IPN" ]] && firefox http://inventree.tortoise-chickadee.ts.net/part/$IPN/
