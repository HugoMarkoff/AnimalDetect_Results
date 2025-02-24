AnimalDetectSorter - Windows 64-bit

Unpacking and Placement:
1. Download and unzip the file.
2. Place `AnimalDetectSorter_windows_amd64.exe` in the same folder as your coco_labels JSON file and images.

Running the Executable:
1. Double-click `AnimalDetectSorter_windows_amd64.exe` to run.
2. If nothing happens, try running as administrator:
   - Right-click on the file and select "Run as administrator".
   - Or, open PowerShell in the folder and run:
     .\AnimalDetectSorter_windows_amd64.exe

Running the Python Script:
1. Ensure Python is installed by running:
   python --version
2. If Python is not installed, download it from https://www.python.org/downloads/
3. Move `AnimalDetectSorter.py` to your project folder (with coco_labels JSON and images).
4. Open PowerShell in the folder and run:
   python AnimalDetectSorter.py

Additional Notes:
- Ensure that images are placed in subfolders where the script can find them.
- The script will sort images based on detected categories from the JSON file.
