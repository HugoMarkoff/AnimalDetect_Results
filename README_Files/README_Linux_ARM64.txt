AnimalDetectSorter - Linux ARM64

Unpacking and Placement:
1. Download and unzip the file.
2. Place `sorting_script_linux_arm64` in the same folder as your coco_labels JSON file(s).

Running the Executable:
1. Open a terminal and navigate to the folder containing the file.
2. Run the following command to make it executable:
   chmod +x sorting_script_linux_arm64
3. Run the sorter with:
   ./sorting_script_linux_arm64

Running the Python Script:
1. Ensure Python is installed by running:
   python3 --version
2. If Python is not installed, install it using:
   sudo apt install python3
3. Move `sorting_script_python.py` to your project folder.
4. Run the script with:
   python3 sorting_script_python.py

Running the Bash Script:
1. Move `sorting_script_bash.sh` to your project folder.
2. Make it executable by running:
   chmod +x sorting_script_bash.sh
3. Run the script with:
   ./sorting_script_bash.sh

Running the R script:
Prerequisites
R (version 3.0 or higher) installed on your system.
The jsonlite package installed. To install globally run:
Rscript -e "install.packages('jsonlite', repos='https://cloud.r-project.org')"

1. Move `sorting_scrip_r.R` to your project folder.
2. chmod +x sorting_script_r.R 
3. Run Rscript sorting_script_r.R

Additional Notes:
- Ensure that images are placed in subfolders where the script can find them.
- The script will sort images based on detected categories from the JSON file.