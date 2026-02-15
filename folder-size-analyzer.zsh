#!/bin/zsh

# Folder Size Analyzer for macOS
# Shows which folders are taking up the most disk space

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
DEPTH=1
TARGET_DIR="${1:-.}"
NUM_RESULTS=20

# Print usage
print_usage() {
    echo "Usage: $0 [directory] [options]"
    echo ""
    echo "Options:"
    echo "  -d, --depth N       Depth to scan (default: 1)"
    echo "  -n, --num N         Number of results to show (default: 20)"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                  # Scan current directory"
    echo "  $0 ~                # Scan home directory"
    echo "  $0 /Users -d 2      # Scan /Users with depth 2"
    echo "  $0 . -n 10          # Show top 10 folders"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--depth)
            DEPTH="$2"
            shift 2
            ;;
        -n|--num)
            NUM_RESULTS="$2"
            shift 2
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            if [[ -d "$1" ]]; then
                TARGET_DIR="$1"
            fi
            shift
            ;;
    esac
done

# Convert to absolute path
TARGET_DIR=$(cd "$TARGET_DIR" 2>/dev/null && pwd)

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "${RED}Error: Directory '$TARGET_DIR' does not exist${NC}"
    exit 1
fi

echo "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "${GREEN}Folder Size Analyzer${NC}"
echo "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "Scanning: ${YELLOW}$TARGET_DIR${NC}"
echo "Depth: $DEPTH | Showing top $NUM_RESULTS folders"
echo "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Show overall disk usage
echo "${GREEN}Overall Disk Usage:${NC}"
df -h "$TARGET_DIR" | tail -1 | awk '{print "  Used: " $3 " / " $2 " (" $5 ")"}'
echo ""

echo "Analyzing folders... (this may take a moment)"
echo ""

# Use du to find folder sizes and sort them
# -d for depth, -h for human readable, -x to stay on same filesystem
du -d "$DEPTH" -h -x "$TARGET_DIR" 2>/dev/null | \
    sort -rh | \
    head -n "$NUM_RESULTS" | \
    awk -v target="$TARGET_DIR" -v red="$RED" -v yellow="$YELLOW" -v green="$GREEN" -v nc="$NC" '
    BEGIN {
        printf "%-12s %s\n", "SIZE", "FOLDER"
        printf "%-12s %s\n", "────────────", "──────────────────────────────────────────"
    }
    {
        size = $1
        path = substr($0, index($0, $2))
        
        # Color code by size
        if (index(size, "G") > 0) {
            color = red
        } else if (index(size, "M") > 0) {
            if (substr(size, 1, index(size, "M")-1) > 100) {
                color = yellow
            } else {
                color = green
            }
        } else {
            color = green
        }
        
        printf "%s%-12s%s %s\n", color, size, nc, path
    }'

echo ""
echo "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "${GREEN}Common space hogs on macOS:${NC}"
echo "  • ~/Library/Caches"
echo "  • ~/Library/Application Support"
echo "  • ~/Downloads"
echo "  • ~/.Trash"
echo "  • /Library/Caches"
echo ""
echo "To scan these: $0 ~/Library/Caches -d 2"
echo "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
