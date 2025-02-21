# AnimalDetectSorter

## Overview

**AnimalDetectSorter** is a simple project that sorts images into subfolders based on their classes from a COCO-style JSON file (e.g., `coco_labels_*.json`).  
If an image appears in multiple classes, it is **copied** into each corresponding class folder; if it appears in exactly one class, it is **moved** to that folder.

**Goal**: Provide a quick way to organize large sets of images into class-specific folders without needing special dependencies or complicated installations.

**Website**: [www.animaldetect.com](http://www.animaldetect.com)  
**Contact**: hugo@animaldetect.com

---

## Project Structure

1. **COCO JSON Files**  
   - Must begin with `coco_labels`, e.g. `coco_labels_bb4169c3-9ccd-4e32-b592-3c395cf2381d.json`.  
   - Placed in the **same folder** as the script/executable.

2. **Images**  
   - Can be in the same folder or in any subfolder.  
   - Filenames are matched exactly against the `file_name` entries in the COCO JSON.

3. **Sorting**  
   - A folder is created for each category (e.g., `Dog`, `Hyena`, etc.).  
   - Single-category images are **moved** into that folder.  
   - Multi-category images are **copied** to all relevant folders.

---

## 1) Python Script Usage

If you prefer using Python directly and **already** have Python installed:

1. **Requirements**: Python 3. No extra packages needed—only standard libraries.
2. **Place** `sort_coco.py` (or your chosen script name) **in the same folder** as the `coco_labels*.json` files.
3. **Run**:  
   ```bash
   python sort_coco.py
   ```
4. **Prompt**: If multiple `coco_labels*.json` files are found, the script asks which one to use.  
5. **Result**: The script creates category subfolders and sorts/moves images accordingly.

---

## 2) Bash Script Usage

If you have a Unix-like environment (Linux, macOS, or Git Bash / WSL on Windows), you can use the Bash script:

1. **Requirements**:  
   - Bash shell.  
   - [`jq`](https://stedolan.github.io/jq/) to parse JSON (commonly installed on most Linux distros or via `brew install jq` on macOS).
2. **Make it executable**:
   ```bash
   chmod +x sort_coco.sh
   ```
3. **Run**:
   ```bash
   ./sort_coco.sh
   ```
4. **Prompt**: If multiple `coco_labels*.json` are found, you’ll be asked to choose one.  
5. **Result**: Category folders are created, and images are moved/copied accordingly.

---

## 3) Compiling a Standalone Executable (Go)

To avoid **any** external dependencies (no Python or Bash needed), you can compile a single-file **Go** program into an executable for each major operating system.

### 3.1 Prerequisite: Install Go

- Download and install the [Go compiler](https://go.dev/dl/) for your OS.
- Verify installation by running:
  ```bash
  go version
  ```

### 3.2 Cross-Compile for 6 Common Targets

With Go installed, you can produce six separate executables—one each for:

1. **Windows (64-bit)**
2. **Windows (32-bit)**
3. **Linux (64-bit)**
4. **Linux (ARM64)**
5. **macOS (Intel)**
6. **macOS (Apple Silicon)**

Below are example commands from PowerShell or a typical shell. (Adjust as needed for your environment.)

#### Windows 64-bit
```powershell
$env:GOOS = "windows"
$env:GOARCH = "amd64"
go build -o AnimalDetectSorter_windows_amd64.exe animal_detect_sorter.go
```

#### Windows 32-bit
```powershell
$env:GOOS = "windows"
$env:GOARCH = "386"
go build -o AnimalDetectSorter_windows_386.exe animal_detect_sorter.go
```

#### Linux 64-bit
```powershell
$env:GOOS = "linux"
$env:GOARCH = "amd64"
go build -o AnimalDetectSorter_linux_amd64 animal_detect_sorter.go
```

#### Linux ARM64
```powershell
$env:GOOS = "linux"
$env:GOARCH = "arm64"
go build -o AnimalDetectSorter_linux_arm64 animal_detect_sorter.go
```

#### macOS (Intel)
```powershell
$env:GOOS = "darwin"
$env:GOARCH = "amd64"
go build -o AnimalDetectSorter_darwin_amd64 animal_detect_sorter.go
```

#### macOS (Apple Silicon ARM64)
```powershell
$env:GOOS = "darwin"
$env:GOARCH = "arm64"
go build -o AnimalDetectSorter_darwin_arm64 animal_detect_sorter.go
```

### 3.3 Distributing the Executables

After running those 6 commands, you’ll have:

- `AnimalDetectSorter_windows_amd64.exe`  
- `AnimalDetectSorter_windows_386.exe`  
- `AnimalDetectSorter_linux_amd64`  
- `AnimalDetectSorter_linux_arm64`  
- `AnimalDetectSorter_darwin_amd64`  
- `AnimalDetectSorter_darwin_arm64`

**Windows**: Users just **double-click** the `.exe`.  
**macOS & Linux**:  
1. Mark it executable:
   ```bash
   chmod +x AnimalDetectSorter_darwin_amd64
   # or
   chmod +x AnimalDetectSorter_linux_amd64
   ```
2. Run:
   ```bash
   ./AnimalDetectSorter_darwin_amd64
   ```
   (or whichever file matches their system).

When the executable runs, it will search for `coco_labels*.json`, prompt if there are multiple, then sort the images into folders.

---

## 4) Additional Notes

- **Place** the executable (or script) **in the same directory** as your `coco_labels*.json` file(s).  
- **Images** can exist in **any** subfolder. The program (or script) scans everything recursively for matching filenames.  
- If an image is already in the correct place, the script/executable will skip moving/copying to avoid overwriting.  
- Each approach (Python, Bash, or Go) accomplishes the **same** sorting logic. Choose whichever best suits your environment.

---

## Support and Contact

For questions, bugs, or feature requests, please reach out at:  
**Website**: [www.animaldetect.com](http://www.animaldetect.com)  
**Email**: [hugo@animaldetect.com](mailto:hugo@animaldetect.com)

Happy sorting!