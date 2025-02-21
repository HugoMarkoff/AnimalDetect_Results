Sure! Here’s a **user-friendly guide** for running the different versions of **AnimalDetectSorter** across **Windows, macOS, and Linux**. The guide is structured so that users can easily find the relevant instructions for their operating system.

---

# **🐾 AnimalDetectSorter - User Guide**

## **📂 General Instructions**
Regardless of which version you use (**executable, Python, or Bash script**), **place the sorter file in the same folder as your `coco_labels*.json` file(s)**.

### **Required Folder Structure**
```
📂 YourProjectFolder/
 ├── AnimalDetectSorter.exe  (Windows)
 ├── AnimalDetectSorter.sh    (macOS/Linux)
 ├── AnimalDetectSorter.py    (Python)
 ├── coco_labels_abc123.json  (COCO JSON file)
 ├── 🖼️ Images/               (Your images in any subfolders)
```
- **The script will scan subfolders** for images that match filenames in the COCO JSON.
- **Images will be sorted** into folders based on detected categories.

---

# **🖥️ Windows Users**
## **Option 1: Run the Executable (`.exe`)**
✅ **Recommended for Windows users** (No setup required)

### **How to Run**
1. **Download** `AnimalDetectSorter_windows_amd64.exe`.
2. **Move it to your project folder** (where your JSON file is located).
3. **Double-click** the `.exe` file to run.
4. If nothing happens:
   - Try **right-click → Run as administrator** (if file permissions cause issues).
   - Open **PowerShell** in the folder and run:
     ```powershell
     .\AnimalDetectSorter_windows_amd64.exe
     ```

---

## **Option 2: Run the Python Script (`.py`)**
✅ **For users with Python installed**

### **Requirements**
- Python **3.7 or newer** (but it should work with older versions too).
- No additional libraries (only built-in modules).

### **How to Run**
1. **Make sure Python is installed**:
   ```powershell
   python --version
   ```
   If not installed, download it from [python.org](https://www.python.org/downloads/).
2. **Move the Python script** (`AnimalDetectSorter.py`) into your project folder.
3. **Run in PowerShell**:
   ```powershell
   python AnimalDetectSorter.py
   ```
4. If you see an error about Python not being recognized:
   - Try `python3 AnimalDetectSorter.py`
   - Ensure Python is added to the system PATH.

---

## **⚠️ Windows Users: Bash Scripts NOT Supported**
Bash scripts do **not** work natively on Windows. You **cannot** run `AnimalDetectSorter.sh` unless you have:
- **Git Bash** (`bash AnimalDetectSorter.sh`)
- **Windows Subsystem for Linux (WSL)** (`wsl ./AnimalDetectSorter.sh`)
- **Cygwin or MinGW** (`sh AnimalDetectSorter.sh`)

For Windows users, **use the `.exe` or `.py` version instead**.

---

# **🍏 macOS Users**
## **Option 1: Run the Executable (`.bin` or `no-extension` file)**
✅ **Recommended for macOS users** (No dependencies required)

### **How to Run**
1. **Download** `AnimalDetectSorter_darwin_amd64` (Intel) or `AnimalDetectSorter_darwin_arm64` (Apple Silicon).
2. **Move the file to your project folder**.
3. **Mark it executable** (only needs to be done once):
   ```bash
   chmod +x AnimalDetectSorter_darwin_amd64
   ```
4. **Run the sorter**:
   ```bash
   ./AnimalDetectSorter_darwin_amd64
   ```
   or for Apple Silicon:
   ```bash
   ./AnimalDetectSorter_darwin_arm64
   ```

---

## **Option 2: Run the Python Script (`.py`)**
✅ **For users with Python installed**

### **How to Run**
1. **Make sure Python is installed**:
   ```bash
   python3 --version
   ```
   If missing, install via **Homebrew**:
   ```bash
   brew install python3
   ```
2. **Move `AnimalDetectSorter.py`** to your project folder.
3. **Run**:
   ```bash
   python3 AnimalDetectSorter.py
   ```

---

## **Option 3: Run the Bash Script (`.sh`)**
✅ **For advanced users who prefer Bash**

### **How to Run**
1. **Move `AnimalDetectSorter.sh`** into your project folder.
2. **Give execute permission** (only needs to be done once):
   ```bash
   chmod +x AnimalDetectSorter.sh
   ```
3. **Run**:
   ```bash
   ./AnimalDetectSorter.sh
   ```

📌 **If you get a "Permission denied" error**, you might need to change the file attributes:
```bash
sudo chmod +x AnimalDetectSorter.sh
```
Then re-run the script.

---

# **🐧 Linux Users**
## **Option 1: Run the Executable (`.bin` or `no-extension` file)**
✅ **Best for users who don't want to install Python or Bash dependencies**

### **How to Run**
1. **Download** `AnimalDetectSorter_linux_amd64` (for 64-bit) or `AnimalDetectSorter_linux_arm64` (for ARM-based machines).
2. **Move the file to your project folder**.
3. **Make it executable** (only needs to be done once):
   ```bash
   chmod +x AnimalDetectSorter_linux_amd64
   ```
4. **Run the sorter**:
   ```bash
   ./AnimalDetectSorter_linux_amd64
   ```

---

## **Option 2: Run the Python Script (`.py`)**
✅ **For users with Python installed**

### **How to Run**
1. **Make sure Python is installed**:
   ```bash
   python3 --version
   ```
   If missing, install it:
   ```bash
   sudo apt install python3
   ```
2. **Move `AnimalDetectSorter.py`** to your project folder.
3. **Run**:
   ```bash
   python3 AnimalDetectSorter.py
   ```

---

## **Option 3: Run the Bash Script (`.sh`)**
✅ **Best for Linux users who prefer shell scripts**

### **How to Run**
1. **Move `AnimalDetectSorter.sh`** into your project folder.
2. **Make it executable** (only needed once):
   ```bash
   chmod +x AnimalDetectSorter.sh
   ```
3. **Run**:
   ```bash
   ./AnimalDetectSorter.sh
   ```

📌 **If "Permission denied" appears**, try:
```bash
sudo chmod +x AnimalDetectSorter.sh
```
Then re-run the script.

---

# **💡 FAQ**
### **Q: Which version should I use?**
- **Windows** → `.exe` file (easiest) or Python (`.py`) if you have Python installed.
- **macOS** → **Executable** (`AnimalDetectSorter_darwin_*`) or **Python**.
- **Linux** → **Executable** (`AnimalDetectSorter_linux_*`), **Bash**, or **Python**.

### **Q: I get a "Permission denied" error!**
- On macOS/Linux, **make sure the script is executable**:
  ```bash
  chmod +x AnimalDetectSorter.sh
  ```
- If the executable isn’t working, **ensure it’s executable**:
  ```bash
  chmod +x AnimalDetectSorter_linux_amd64
  ```

### **Q: Where should I put my images?**
- Images can be in **any subfolder** of the script location.
- The script will scan all subfolders for matching image filenames.

---

# **📧 Need Help?**
If you're having issues, visit our website or contact us:

🌍 **Website:** [www.animaldetect.com](http://www.animaldetect.com)  
📩 **Email:** hugo@animaldetect.com  

---

### **Now you're all set! 🎉 Just pick the right version for your OS and run AnimalDetectSorter!** 🚀