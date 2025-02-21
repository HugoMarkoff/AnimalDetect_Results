#!/usr/bin/env python3

import os
import json
import shutil
from collections import defaultdict

def main():
    # 1) Find all coco_labels*.json files in current dir
    coco_files = [f for f in os.listdir('.') if f.startswith('coco_labels') and f.endswith('.json')]
    if not coco_files:
        print("No coco_labels JSON files found. Exiting.")
        return
    elif len(coco_files) > 1:
        print("Multiple coco_labels JSON files found:")
        for i, fname in enumerate(coco_files, 1):
            print(f"{i}. {fname}")
        choice = input("Select which file to use (number): ")
        try:
            json_file = coco_files[int(choice) - 1]
        except:
            print("Invalid selection. Exiting.")
            return
    else:
        json_file = coco_files[0]

    print(f"Using {json_file}")

    # 2) Load the chosen JSON
    with open(json_file, 'r') as f:
        data = json.load(f)

    # 3) Create folders for each category (id -> name)
    cat_id_to_name = {}
    for cat in data['categories']:
        cat_id_to_name[cat['id']] = cat['name']
        os.makedirs(cat['name'], exist_ok=True)

    # 4) Map image_id -> file_name
    image_id_to_name = {}
    for img in data['images']:
        image_id_to_name[img['id']] = img['file_name']

    # 5) Build a mapping of image_id -> set of category_ids
    image_cats = defaultdict(set)
    for ann in data['annotations']:
        image_cats[ann['image_id']].add(ann['category_id'])

    # 6) Search all subfolders for image files (by exact filename match)
    all_image_paths = {}
    for root, dirs, files in os.walk('.'):
        for file in files:
            all_image_paths[file] = os.path.join(root, file)

    # 7) For each image, see which categories it belongs to:
    for img_id, cat_ids in image_cats.items():
        file_name = image_id_to_name.get(img_id)
        if not file_name:
            continue  # no such image_id in 'images' section

        full_path = all_image_paths.get(file_name)
        if not full_path:
            print(f"Could not find file '{file_name}' in any subfolder.")
            continue

        # If multiple categories => copy into each folder
        # Otherwise => move into the single folder
        if len(cat_ids) > 1:
            for cid in cat_ids:
                shutil.copy2(full_path, cat_id_to_name[cid])
        else:
            cid = list(cat_ids)[0]
            shutil.move(full_path, cat_id_to_name[cid])

    print("Done sorting images!")

if __name__ == '__main__':
    main()
