#!/usr/bin/env bash

q="$1"
case "$q" in
  =*)
    result=$(echo "${q:1}" | bc -l)
    printf '%s %s\n' "$result" "$q"
    ;;
  *)
    cat "$2"
    ;;
esac
