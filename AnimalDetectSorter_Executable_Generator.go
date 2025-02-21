package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"path/filepath"
)

// Data structures matching the COCO JSON schema
type Category struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

type Image struct {
	ID       int    `json:"id"`
	FileName string `json:"file_name"`
}

type Annotation struct {
	ID         int `json:"id"`
	ImageID    int `json:"image_id"`
	CategoryID int `json:"category_id"`
}

type CocoData struct {
	Images      []Image      `json:"images"`
	Annotations []Annotation `json:"annotations"`
	Categories  []Category   `json:"categories"`
}

func main() {
	// 1) Gather all coco_labels*.json in current directory
	files, err := filepath.Glob("coco_labels*.json")
	if err != nil || len(files) == 0 {
		fmt.Println("No coco_labels*.json files found. Exiting.")
		return
	}

	var chosen string
	if len(files) == 1 {
		chosen = files[0]
		fmt.Printf("Using %s\n", chosen)
	} else {
		fmt.Println("Multiple coco_labels JSON files found:")
		for i, f := range files {
			fmt.Printf("%d. %s\n", i+1, f)
		}
		fmt.Print("Select which file to use (number): ")
		scanner := bufio.NewScanner(os.Stdin)
		if scanner.Scan() {
			txt := scanner.Text()
			var idx int
			_, err := fmt.Sscanf(txt, "%d", &idx)
			if err != nil || idx < 1 || idx > len(files) {
				fmt.Println("Invalid selection. Exiting.")
				return
			}
			chosen = files[idx-1]
		} else {
			fmt.Println("No selection. Exiting.")
			return
		}
	}

	// 2) Parse the chosen JSON file
	coco, err := parseCoco(chosen)
	if err != nil {
		fmt.Printf("Failed to parse %s: %v\n", chosen, err)
		return
	}

	// 3) Make folders for each category
	catMap := make(map[int]string) // category_id -> category_name
	for _, c := range coco.Categories {
		catMap[c.ID] = c.Name
		os.MkdirAll(c.Name, 0755)
	}

	// 4) Build imageID -> filename
	imageMap := make(map[int]string)
	for _, img := range coco.Images {
		imageMap[img.ID] = img.FileName
	}

	// 5) Build imageID -> set of category IDs
	imageCats := make(map[int]map[int]bool)
	for _, ann := range coco.Annotations {
		if imageCats[ann.ImageID] == nil {
			imageCats[ann.ImageID] = make(map[int]bool)
		}
		imageCats[ann.ImageID][ann.CategoryID] = true
	}

	// 6) Gather all files from subfolders into a map: filename -> full path
	allPaths := make(map[string]string)
	filepath.Walk(".", func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return nil
		}
		if !info.IsDir() {
			base := filepath.Base(path)
			allPaths[base] = path
		}
		return nil
	})

	// 7) Sort
	for imgID, catSet := range imageCats {
		filename := imageMap[imgID]
		srcPath, exists := allPaths[filename]
		if !exists {
			fmt.Printf("Could not find file '%s' in any subfolder.\n", filename)
			continue
		}
		// Convert the set of category IDs to a slice
		cats := make([]int, 0, len(catSet))
		for c := range catSet {
			cats = append(cats, c)
		}

		// If multiple categories => copy to each folder
		// Else move to single folder
		if len(cats) > 1 {
			for _, cid := range cats {
				dst := filepath.Join(catMap[cid], filename)
				safeCopy(srcPath, dst)
			}
		} else {
			cid := cats[0]
			dst := filepath.Join(catMap[cid], filename)
			safeMove(srcPath, dst)
		}
	}

	fmt.Println("Done sorting images!")
}

func parseCoco(path string) (*CocoData, error) {
	data, err := ioutil.ReadFile(path)
	if err != nil {
		return nil, err
	}
	var c CocoData
	if err := json.Unmarshal(data, &c); err != nil {
		return nil, err
	}
	return &c, nil
}

func safeMove(src, dst string) {
	if fileExists(dst) {
		fmt.Printf("File '%s' already in destination '%s'. Skipping move.\n", src, dst)
		return
	}
	// Attempt rename first
	if err := os.Rename(src, dst); err != nil {
		// If rename fails (e.g. cross-filesystem move), fallback to copy+remove
		if copyFile(src, dst) == nil {
			_ = os.Remove(src)
		} else {
			fmt.Printf("Failed to move '%s' -> '%s'\n", src, dst)
		}
	}
}

func safeCopy(src, dst string) {
	if fileExists(dst) {
		fmt.Printf("File '%s' already in destination '%s'. Skipping copy.\n", src, dst)
		return
	}
	if err := copyFile(src, dst); err != nil {
		fmt.Printf("Failed to copy '%s' -> '%s': %v\n", src, dst, err)
	}
}

func copyFile(src, dst string) error {
	in, err := os.Open(src)
	if err != nil {
		return err
	}
	defer in.Close()

	out, err := os.Create(dst)
	if err != nil {
		return err
	}
	defer func() {
		_ = out.Close()
	}()

	_, err = io.Copy(out, in)
	if err != nil {
		return err
	}

	// Copy file mode (permissions)
	srcInfo, err := os.Stat(src)
	if err == nil {
		_ = os.Chmod(dst, srcInfo.Mode())
	}
	return nil
}

func fileExists(path string) bool {
	info, err := os.Stat(path)
	return err == nil && !info.IsDir()
}
