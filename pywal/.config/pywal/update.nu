#!/bin/env nu


let path = $env.FILE_PWD

let modules = [
  gtk,
  obsidian,
]


def update_colors [] {
  let colors = open /home/silas/.cache/wal/colors.json
  let colors = $colors.special | merge $colors.colors

  let save = "/home/silas/.cache/wal"

  $modules | each {|module|
    ls $'($path)/($module)' | where name =~ "/colors" | each {|file| $colors | format (open $file.name) | save -f ($file.name | parse "{_}/colors{prefix}.{extension}" | format $"($save)/colors-($module){prefix}.{extension}")} 


  }
}

def update_scripts [] {
  $modules | each {|module| nu $"($path)/($module)/update.nu"}
}


pywalfox update
update_colors
update_scripts

