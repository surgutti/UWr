#!/usr/bin/env bash
set -euo pipefail

UI=${1:-whiptail}
DIR=${2:-.}
PLAYER=${PLAYER:-mpg123}

FILES=()
LABELS=()

read_tracks() {
  local file album artist title

  mapfile -d '' -t FILES < <(
    find "$DIR" -type f -iname '*.mp3' -print0 | sort -z
  )

  ((${#FILES[@]})) || {
    printf 'No mp3 files found in: %s\n' "$DIR" >&2
    exit 1
  }

  for file in "${FILES[@]}"; do
    album=$(mp3info -p '%l' -- "$file" 2>/dev/null || true)
    artist=$(mp3info -p '%a' -- "$file" 2>/dev/null || true)
    title=$(mp3info -p '%t' -- "$file" 2>/dev/null || true)

    [[ -n $album  ]] || album='?'
    [[ -n $artist ]] || artist='?'
    [[ -n $title  ]] || title=$(basename "$file")

    LABELS+=("$album ($artist): $title")
  done
}

choose_track() {
  local entries=()
  local i choice

  for i in "${!FILES[@]}"; do
    entries+=("$i" "${LABELS[$i]}")
  done

  case "$UI" in
    whiptail)
      whiptail \
        --title 'mp3play' \
        --menu 'Choose a track' 22 90 14 \
        "${entries[@]}"
      ;;
    dialog)
      dialog \
        --clear \
        --stdout \
        --title 'mp3play' \
        --menu 'Choose a track' 22 90 14 \
        "${entries[@]}"
      ;;
    zenity)
      choice=$(
        zenity --list \
          --title='mp3play' \
          --text='Choose a track' \
          --width=900 --height=600 \
          --column='ID' --column='Track' \
          --hide-column=1 --print-column=1 \
          "${entries[@]}" \
          2>/dev/null
      ) || return 1
      printf '%s\n' "$choice"
      ;;
    yad)
      choice=$(
        yad --list \
          --title='mp3play' \
          --text='Choose a track' \
          --width=900 --height=600 \
          --column='ID:NUM' --column='Track:TEXT' \
          --hide-column=1 --print-column=1 \
          --separator='' \
          --search-column=2 \
          "${entries[@]}" \
          2>/dev/null
      ) || return 1
      printf '%s\n' "${choice%%|*}"
      ;;
    *)
      printf 'Usage: %s {whiptail|dialog|zenity|yad} [directory]\n' "$0" >&2
      exit 2
      ;;
  esac
}

play_track() {
  "$PLAYER" -- "${FILES[$1]}"
}

main() {
  local choice

  read_tracks

  while true; do
    choice=$(choose_track) || break
    play_track "$choice"
  done
}

main "$@"
