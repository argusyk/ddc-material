check_brackets() {
  input_string=$1
  stack=()
  brackets=("(" ")" "[" "]" "{" "}")

  if [ -z "$input_string" ]; then
    return 1
  fi

  for (( i=0; i<${#input_string}; i++ )); do
    char="${input_string:$i:1}"
    if [[ " ${brackets[*]} " =~ *"$char"* ]]; then
      stack+=("$char")
    else
      if [[ ${#stack[@]} -eq 0 ]]; then
        return 1
      else
        if [[ "${brackets[-1]}" != "$char" ]]; then
          return 1
        fi
        unset 'stack[-1]'
      fi
    fi
  done

  return ${#stack[@]} -eq 0
}

