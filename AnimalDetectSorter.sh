#!/bin/bash

set -e  # Exit on errors
set -u  # Exit on unset variables
set -o pipefail  # Catch errors in pipes

echo "Starting AnimalDetectSorter..."

# Check if jq is installed
if ! command -v jq &>/dev/null; then
  echo "ERROR: 'jq' is required but not found."
  echo "Install it with: 'sudo apt install jq' (Linux) or 'brew install jq' (macOS)."
  exit 1
fi

# Step 1: Find all coco_labels JSON files
coco_files=($(ls coco_labels*.json 2>/dev/null || true))
if [ ${#coco_files[@]} -eq 0 ]; then
  echo "No coco_labels JSON files found. Exiting."
  exit 1
elif [ ${#coco_files[@]} -gt 1 ]; then
  echo "Multiple coco_labels JSON files found:"
  for i in "${!coco_files[@]}"; do
    echo "$((i+1))) ${coco_files[$i]}"
  done
  read -p "Select which file to use (number): " choice
  json_file="${coco_files[$((choice-1))]}"
else
  json_file="${coco_files[0]}"
fi

echo "Using JSON file: $json_file"

# Step 2: Create category folders
category_count=$(jq '.categories | length' "$json_file")
for ((i=0; i<category_count; i++)); do
  cname=$(jq -r ".categories[$i].name" "$json_file")
  mkdir -p "$cname"
done

# Step 3: Map image_id -> filename
declare -A image_names
image_count=$(jq '.images | length' "$json_file")
for ((i=0; i<image_count; i++)); do
  iid=$(jq -r ".images[$i].id" "$json_file")
  fname=$(jq -r ".images[$i].file_name" "$json_file")
  image_names["$iid"]="$fname"
done

# Step 4: Map image_id -> category IDs
declare -A image_cats
ann_count=$(jq '.annotations | length' "$json_file")
for ((i=0; i<ann_count; i++)); do
  iid=$(jq -r ".annotations[$i].image_id" "$json_file")
  cid=$(jq -r ".annotations[$i].category_id" "$json_file")
  image_cats["$iid"]+="$cid "
done

# Step 5: Gather all images in subfolders
declare -A file_paths
while IFS= read -r file; do
  b=$(basename "$file")
  file_paths["$b"]="$file"
done < <(find . -type f)

# Step 6: Sort images
for iid in "${!image_cats[@]}"; do
  fname="${image_names["$iid"]}"
  path="${file_paths["$fname"]}"
  
  if [ -z "$path" ]; then
    continue  # Skip if file not found
  fi

  # Get categories for this image
  IFS=' ' read -r -a cids <<< "${image_cats["$iid"]}"
  
  if [ ${#cids[@]} -gt 1 ]; then
    # Copy into each folder (multiple categories)
    for c in "${cids[@]}"; do
      cname=$(jq -r ".categories[] | select(.id == $c) | .name" "$json_file")
      cp -p "$path" "$cname/"
    done
  else
    # Move to the single category folder
    cname=$(jq -r ".categories[] | select(.id == ${cids[0]}) | .name" "$json_file")
    mv "$path" "$cname/"
  fi
done

echo "Sorting complete!"
