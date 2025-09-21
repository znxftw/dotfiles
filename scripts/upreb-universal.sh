#!/usr/bin/env zsh

# vim:filetype=zsh syntax=zsh tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent fileencoding=utf-8

# This script is used to run the `git upreb` command for all the locally checked-out branches of the specified folder. If no folder is specified, the script defaults to using the current directory.

# Source shell helpers if they aren't already loaded
type section_header &> /dev/null 2>&1 || source "${HOME}/.shellrc"

local folder="${1:-$(pwd)}"
section_header "$(yellow 'Processing') $(purple "${folder}")"

local current_branch="$(git -C "${folder}" br)"
echo "current branch: $(yellow "${current_branch}")"
local local_branches=($(git -C "${folder}" branch --format='%(refname:short)'))
if [[ ${#local_branches[@]} -gt 0 ]]; then
  # remove the current_branch from the list of branches
  local_branches=("${(@)local_branches:#$current_branch}")
  # add the current branch to the end of the list
  local_branches+="${current_branch}"
  for branch in "${local_branches[@]}"; do
    echo "processing: $(yellow "${branch}")"
    git -C "${folder}" switch "${branch}"
    git -C "${folder}" upreb
    git -C "${folder}" push
    echo "$(red $(print_chars_for_length))"
  done
  unset local_branches
fi
unset current_branch
