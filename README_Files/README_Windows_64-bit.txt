AnimalDetectSorter - Windows 64-bit

Unpacking and Placement:
1. Download and unzip the file.
2. Place `sorting_script_Windows_64bit.exe` in the same folder as your coco_labels JSON file and images.

Running the Executable:
1. Double-click `sorting_script_Windows_64bit.exe` to run.
2. If nothing happens, try running as administrator:
   - Right-click on the file and select "Run as administrator".
   - Or, open PowerShell in the folder and run:
     .\sorting_script_Windows_64bit.exe

Running the Python Script:
1. Ensure Python is installed by running:
   python --version
2. If Python is not installed, download it from https://www.python.org/downloads/
3. Move `sorting_script_python.py` to your project folder (with coco_labels JSON and images).
4. Open PowerShell in the folder and run:
   python sorting_script_python.py

Running the R script:
Prerequisites
R (version 3.0 or higher) installed on your system.
The jsonlite package installed. To install globally run:
Rscript -e "install.packages('jsonlite', repos='https://cloud.r-project.org')"

1. Move `sorting_scrip_r.R` to your project folder.
2. Open PowerShell and navigate to the folder
3. Run Rscript sorting_script_r.R 
(# or if Rscript not on PATH, use full path:& "C:\Program Files\R\R-4.x.x\bin\Rscript.exe" .\sorting_script_r.R)

Additional Notes:
- Ensure that images are placed in subfolders where the script can find them.
- The script will sort images based on detected categories from the JSON file.
