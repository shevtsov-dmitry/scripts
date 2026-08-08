#!/usr/bin/env python3

import sys

# ANSI escape codes for formatting
RED = "\033[31m"
BOLD = "\033[1m"
RESET = "\033[0m"

args = sys.argv[1:]


if len(args) == 0 or not args[0].strip():
    print(f"{BOLD}{RED}Error: enter repository name.{RESET}")
    sys.exit(1)

repo_name = args[0]

commands = f"""
git remote remove origin
git remote add origin http://localhost:3013/shd/{repo_name}.git
git push --set-upstream origin main
git remote remove github
git remote add github git@github.com:shevtsov-dmitry/{repo_name}.git
git push github
"""

print(commands)

sys.exit(0)
