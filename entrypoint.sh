#!/usr/bin/env bash
# shellcheck source=handler/
for HF in handlers/*; do source "$HF"; done
# shellcheck source=utilities/
for UF in utilities/*; do source "$UF"; done

if [ -n "${COMMENTER_ECHO+x}" ]; then
  set -x
fi

###################
# Procedural body #
###################
validate_inputs "$@"
parse_args "$@"

output=""

if [[ $COMMAND == 'fmt' ]]; then
  output=execute_fmt
  exit 0
fi

if [[ $COMMAND == 'init' ]]; then
  output=execute_init
  exit 0
fi

if [[ $COMMAND == 'plan' ]]; then
  output=execute_plan
  exit 0
fi

if [[ $COMMAND == 'validate' ]]; then
  output=execute_validate
  exit 0
fi

if [[ $COMMAND == 'tflint' ]]; then
  output=execute_tflint
  exit 0
fi

if [[ ! -z $output ]]; then
  comment_id="$output | jq -r '.id'"
  echo "comment_id=$comment_id" >>$GITHUB_OUTPUT
fi
