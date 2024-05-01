#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#!/bin/bash

# Check for dependencies
DEPENDENCIES=("pdftotext" "pdfgrep")
for dep in "${DEPENDENCIES[@]}"; do
  if ! command -v "$dep" &> /dev/null; then
      echo "Error: '$dep' is not installed. Please install it using your package manager (e.g., pacman -S poppler for pdftotext)."
      exit 1
  fi
done

# Check for arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <search_term> </path/to/pdf/folder>"
    exit 1
fi

SEARCH_TERM="$1"
PDF_FOLDER="$2"

# Function to choose PDF text extraction method
extract_text() {
  local pdf_file="$1"

  # Prioritize pdfgrep for its built-in matching capabilities
  if command -v pdfgrep &> /dev/null; then
    pdfgrep -i "$SEARCH_TERM" "$pdf_file"
  else
    # Fallback to pdftotext and grep
    pdftotext "$pdf_file" - | grep -i "$SEARCH_TERM"
  fi
}
#
# Search for PDFs and extract matching text
for pdf_file in "$PDF_FOLDER"/*.pdf; do
  # Handle potential errors during text extraction
  if matches=$(extract_text "$pdf_file" 2>/dev/null); then
    echo "--------------------"
    echo "File: $pdf_file"
    echo "$matches"
  fi
done
