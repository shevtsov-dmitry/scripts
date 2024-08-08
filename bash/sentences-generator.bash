#!/bin/bash

text="lovely. гватемала is gonna be free. and then my man. go on."
is_next_word_uppercased=false
string_builder=""

IFS=' ' read -r -a words <<<"$text" # split string to an array
words=($(printf "%s\n" "${words[@]}" | shuf))

for ((i = 0; i < ${#words[@]}; i++)); do # define length of an array
    cur_word=${words[$i]}
    word_end="${cur_word: -1}" # get char ends with string
    is_end=false
    if [[ $word_end = "." || $word_end = "!" || $word_end = "?" ]]; then
        is_end=true
    fi

    # manage first word
    if [[ $i = 0 && $is_end = true ]]; then
        cur_word="${cur_word^}"
        is_next_word_uppercased=true
    elif [[ $i = 0 && $is_end = false ]]; then
        cur_word="${cur_word^}"
    fi

    # manage rest words
    if [[ $is_next_word_uppercased = true ]]; then
        cur_word="${cur_word^}"
        is_next_word_uppercased=false
    elif [[ $is_end = true ]]; then
        is_next_word_uppercased=true
    fi

    string_builder="$string_builder $cur_word"
done

echo "$string_builder"
