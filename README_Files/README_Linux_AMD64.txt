AnimalDetectSorter - Linux 64-bit

Unpacking and Placement:
1. Download and unzip the file.
2. Place `AnimalDetectSorter_linux_amd64` in the same folder as your coco_labels JSON file and images.


Running the Executable:
1. Open a terminal and navigate to the folder containing the file.
2. Run the following command to make it executable:
   chmod +x AnimalDetectSorter_linux_amd64
3. Run the sorter with:
   ./AnimalDetectSorter_linux_amd64

Running the Python Script:
1. Ensure Python is installed by running:
   python3 --version
2. If Python is not installed, install it using:
   sudo apt install python3
3. Move `AnimalDetectSorter.py` to your project folder.
4. Run the script with:
   python3 AnimalDetectSorter.py

Running the Bash Script:
1. Move `AnimalDetectSorter.sh` to your project folder.
2. Make it executable by running:
   chmod +x AnimalDetectSorter.sh
3. Run the script with:
   ./AnimalDetectSorter.sh

Additional Notes:
- Ensure that images are placed in subfolders where the script can find them.
- The script will sort images based on detected categories from the JSON file.