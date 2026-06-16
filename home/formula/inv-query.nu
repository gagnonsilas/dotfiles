
let auth = open ~/.secrets/fsae-inventree.txt


def main [--reload (-r)] {
  let test = $in
  # let mfr = http get --headers {Authorization: (["Token ", $auth] | str join)} "http://docker.goatfastracing.com:10003/api/company/part/"
  # let mfrs = http get --headers {Authorization: (["Token ", $auth] | str join)} "http://docker.goatfastracing.com:10003/api/company/"

  if $reload {
    let parts = http get --headers {Authorization: (["Token ", $auth] | str join)} "http://inventree.goatfastracing.com/api/part/"

    $parts | sort-by pk | select pk IPN name description | each {|x| $x | items {|a, b| $b | into string} | str join " | " | str replace -a -r "µ" "u" } | save -f ~/.cache/fsae/inv.txt
    

    notify-send "Inventory Updated" 
  }

  let pk = open ~/.cache/fsae/inv.txt | rofi -dmenu -i -matching-negate-char '\0' | sed 's/ .*//'

  if (not ($pk| is-empty)) {
    firefox $"http://inventree.goatfastracing.com/part/($pk)/"
  }
}


