#!/usr/bin/env Rscript

# This script:
# 1) Find coco_labels*.json in the working directory
# 2) Let the user choose if multiple are found
# 3) Parse JSON for categories, images, and annotations
# 4) Create folders for each category name
# 5) Map images to category folders by copy (if multiple) or move (if single)

# Load required package
if (!require(jsonlite, quietly = TRUE)) {
  install.packages("jsonlite", repos = "https://cloud.r-project.org")
  library(jsonlite)
}

# 1) Find JSON files
json_files <- list.files(pattern = "^coco_labels.*\\.json$")
if (length(json_files) == 0) {
  cat("No coco_labels JSON files found. Exiting.\n")
  quit(status = 1)
} else if (length(json_files) > 1) {
  cat("Multiple coco_labels JSON files found:\n")
  for (i in seq_along(json_files)) {
    cat(i, ". ", json_files[i], "\n", sep = "")
  }
  choice <- as.integer(readline("Select which file to use (number): "))
  if (is.na(choice) || choice < 1 || choice > length(json_files)) {
    cat("Invalid selection. Exiting.\n")
    quit(status = 1)
  }
  json_file <- json_files[choice]
} else {
  json_file <- json_files[1]
}
cat("Using ", json_file, "\n", sep = "")

# 2) Load JSON
data <- fromJSON(json_file)

# 3) Create category folders
# data$categories is a data.frame with 'id' and 'name'
cat_id_to_name <- setNames(
  as.character(data$categories$name),
  as.character(data$categories$id)
)
for (dir_name in unique(cat_id_to_name)) {
  dir.create(dir_name, showWarnings = FALSE)
}

# 4) Map image IDs to file names
# data$images is a data.frame with 'id' and 'file_name'
image_id_to_name <- setNames(
  as.character(data$images$file_name),
  as.character(data$images$id)
)

# 5) Build mapping of image -> categories
image_cats <- list()
# ensure data$annotations is a data.frame with columns 'image_id' and 'category_id'
ann_df <- data$annotations
for (i in seq_len(nrow(ann_df))) {
  key <- as.character(ann_df$image_id[i])
  image_cats[[key]] <- unique(c(image_cats[[key]], ann_df$category_id[i]))
}

# 6) Find all image files in subdirectories
all_paths <- list.files(path = ".", recursive = TRUE, full.names = TRUE)
file_map <- setNames(all_paths, basename(all_paths))

# 7) Copy/move images into category folders
for (id_chr in names(image_cats)) {
  fname <- image_id_to_name[id_chr]
  full_path <- file_map[[fname]]
  if (is.null(full_path)) {
    cat(sprintf("Could not find file '%s' in any subfolder.\n", fname))
    next
  }
  cats <- image_cats[[id_chr]]
  if (length(cats) > 1) {
    for (cid in cats) {
      dest_dir <- cat_id_to_name[as.character(cid)]
      file.copy(full_path, file.path(dest_dir, fname), overwrite = TRUE)
    }
  } else {
    dest_dir <- cat_id_to_name[as.character(cats)]
    file.rename(full_path, file.path(dest_dir, fname))
  }
}

cat("Done sorting images!\n")
