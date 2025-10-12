#!/bin/bash

# Script to restart all stacks that depend on the database
# Run this after restarting the database stack

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}=========================================="
echo -e "Restarting database-dependent stacks..."
echo -e "==========================================${NC}"
echo

# Array of directories that depend on the database
DB_DEPENDENT_STACKS=(
    "media_managers"
    "kaizoku"
    "monitoring"
    "public"
)

# Function to restart a stack
restart_stack() {
    local stack_dir=$1
    echo -e "${BOLD}${MAGENTA}=========================================="
    echo -e "Restarting: ${YELLOW}$stack_dir${NC}"
    echo -e "${BOLD}${MAGENTA}==========================================${NC}"
    cd "$SCRIPT_DIR/$stack_dir"

    echo -e "${BLUE}Stopping containers...${NC}"
    docker compose down

    echo -e "${GREEN}Starting containers...${NC}"
    docker compose up -d
    echo
}

# Restart each stack
for stack in "${DB_DEPENDENT_STACKS[@]}"; do
    if [ -d "$SCRIPT_DIR/$stack" ]; then
        restart_stack "$stack"
    else
        echo -e "${RED}Warning: Directory $stack not found, skipping...${NC}"
        echo
    fi
done

echo -e "${BOLD}${GREEN}=========================================="
echo -e "✓ All database-dependent stacks restarted!"
echo -e "==========================================${NC}"
echo
echo -e "${CYAN}You can check the status with:${NC}"
echo -e "  ${YELLOW}docker ps${NC}"
echo
echo -e "${CYAN}Or check logs for a specific stack:${NC}"
echo -e "  ${YELLOW}cd <stack-directory> && docker compose logs -f${NC}"
