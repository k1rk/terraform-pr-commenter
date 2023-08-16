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
  execute_fmt >>$output
  exit 0
fi

if [[ $COMMAND == 'init' ]]; then
  execute_init >>$output
  exit 0
fi

if [[ $COMMAND == 'plan' ]]; then
  execute_plan >>$output
  exit 0
fi

if [[ $COMMAND == 'validate' ]]; then
  execute_validate >>$output
  exit 0
fi

if [[ $COMMAND == 'tflint' ]]; then
  execute_tflint >>$output
  exit 0
fi

if [[ ! -z $output ]]; then
  comment_id="$output | jq -r '.id'"
  echo "comment_id=$comment_id" >>$GITHUB_OUTPUT
fi
