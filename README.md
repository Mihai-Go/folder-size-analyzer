# 📊 Folder Size Analyzer

A fast and colorful zsh script for macOS that helps you identify which folders are hogging your disk space.

## Features

- 🎨 **Color-coded output** - Red for GB, yellow for large MB, green for smaller sizes
- 📈 **Disk usage overview** - Shows overall disk usage at a glance
- 🔍 **Customizable depth** - Scan as deep as you need
- ⚡ **Fast and efficient** - Uses native `du` command for speed
- 🎯 **Sorted results** - Largest folders first
- 💡 **Helpful tips** - Suggests common macOS space hogs to check

## Installation

### Quick Install (Recommended)

```bash
# Download the script
curl -O https://raw.githubusercontent.com/YOUR_USERNAME/REPO_NAME/main/folder-size-analyzer.zsh

# Make it executable
chmod +x folder-size-analyzer.zsh

# Move to a directory in your PATH
sudo mv folder-size-analyzer.zsh /usr/local/bin/folder-size-analyzer
```

### Manual Install

1. Download `folder-size-analyzer.zsh`
2. Make it executable: `chmod +x folder-size-analyzer.zsh`
3. Move it to your preferred location

### Add to PATH (Optional)

To run the script from anywhere:

```bash
# Create a scripts directory
mkdir -p ~/scripts
mv folder-size-analyzer.zsh ~/scripts/folder-size-analyzer

# Add to your ~/.zshrc
echo 'export PATH="$HOME/scripts:$PATH"' >> ~/.zshrc

# Reload your shell
source ~/.zshrc
```

## Usage

```bash
folder-size-analyzer [directory] [options]
```

### Options

| Option | Description | Default |
|--------|-------------|---------|
| `-d, --depth N` | Depth to scan | 1 |
| `-n, --num N` | Number of results to show | 20 |
| `-h, --help` | Show help message | - |

### Examples

```bash
# Scan current directory
folder-size-analyzer

# Scan home directory
folder-size-analyzer ~

# Scan with depth 2
folder-size-analyzer /Users -d 2

# Show top 10 folders only
folder-size-analyzer . -n 10

# Deep dive into Library folder
folder-size-analyzer ~/Library -d 3 -n 15

# Scan Downloads folder
folder-size-analyzer ~/Downloads -d 2
```

## Common Space Hogs on macOS

The script will remind you to check these common culprits:

- `~/Library/Caches` - Application caches
- `~/Library/Application Support` - App data
- `~/Downloads` - Downloaded files
- `~/.Trash` - Trash bin
- `/Library/Caches` - System-wide caches

## Output Example

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Folder Size Analyzer
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Scanning: /Users/username
Depth: 1 | Showing top 20 folders
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Overall Disk Usage:
  Used: 234G / 500G (47%)

Analyzing folders... (this may take a moment)

SIZE         FOLDER
──────────── ──────────────────────────────────────────
45G          /Users/username/Library
23G          /Users/username/Movies
12G          /Users/username/Downloads
8.5G         /Users/username/Documents
...
```

## Tips

- **Start broad, then narrow down**: First scan your home directory with depth 1, then dive deeper into large folders
- **Check Library regularly**: `~/Library` often contains large caches that can be cleaned
- **Empty your trash**: `~/.Trash` can accumulate gigabytes over time
- **Be cautious**: Don't delete folders you're unsure about - research first!

## Troubleshooting

### Permission Denied Errors

Some system folders require elevated permissions:

```bash
sudo folder-size-analyzer /Library -d 2
```

### Script Not Found

Make sure the script is in your PATH or use the full path:

```bash
~/scripts/folder-size-analyzer ~
```

## Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests

## License

MIT License - feel free to use and modify as needed.

## Author

Created to help Mac users reclaim their disk space, one folder at a time.

---

**Note**: This script only analyzes disk usage. It does not delete any files. Always verify before deleting large folders!
