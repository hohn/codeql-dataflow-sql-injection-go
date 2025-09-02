#!/usr/bin/env bash
set -euo pipefail

go build -o add-user-go ./add-user.go
echo "Built ./add-user-go"

