#!/bin/bash

# Check if filename argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Assign the filename argument to a variable
filename=$1

# Read the solc version from foundry.toml
solc_version=$(grep 'solc' foundry.toml | awk -F'"' '{print $2}')
# Check if solc version was found
if [ -z "$solc_version" ]; then
  echo "Error: Could not find solc version in foundry.toml"
  exit 1
fi

# Create the src/filename.sol file with the specified content
src_file="src/${filename}.sol"
echo "// SPDX-License-Identifier: MIT" > "$src_file"
echo "pragma solidity $solc_version;" >> "$src_file"
echo "" >> "$src_file"
echo "contract $filename {}" >> "$src_file"
echo "Created $src_file"

# Create the test/filename.t.sol file with the specified content
test_file="test/${filename}.t.sol"
echo "// SPDX-License-Identifier: MIT" > "$test_file"
echo "pragma solidity $solc_version;" >> "$test_file"
echo "" >> "$test_file"
echo "import \"./Helper.sol\";" >> "$test_file"
echo "" >> "$test_file"
echo "contract ${filename}Test is Helper {}" >> "$test_file"
echo "Created $test_file"

# Create the script/Deployfilename.s.sol file with the specified content
script_file="script/Deploy${filename}.s.sol"
echo "// SPDX-License-Identifier: MIT" > "$script_file"
echo "pragma solidity $solc_version;" >> "$script_file"
echo "" >> "$script_file"
echo "import \"forge-std/src/Script.sol\";" >> "$script_file"
echo "" >> "$script_file"
echo "contract Deploy${filename} {}" >> "$script_file"
echo "Created $script_file"

echo "All files created successfully!"