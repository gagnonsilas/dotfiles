#!/bin/env nu

let colors = open /home/silas/.cache/wal/colors.json
let colors = $colors.special | merge $colors.colors

$colors | transpose | format "@define-color {column0} {column1};" | save -f /home/silas/.cache/wal/colors-gtk.css


