#!/bin/env nu

let path = $env.FILE_PWD

let obsidian_dir = "~/Obsidian/.obsidian/themes/wal/theme.css"

let prefix = open $"($path)/format-prefix.css"
let suffix = open $"($path)/format-suffix.css"
let colors = open "~/.cache/wal/colors-obsidian.css"

$"($prefix)($colors)($suffix)" | save -f $obsidian_dir

