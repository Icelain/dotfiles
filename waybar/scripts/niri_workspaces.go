package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"sort"
	"strings"
)

type Workspace struct {
	ID        int  `json:"id"`
	IsFocused bool `json:"is_focused"`
	IsActive  bool `json:"is_active"`
}

type Output struct {
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
}

// Store workspace IDs globally for click handling
var workspaceIDs []int

func getWorkspaces() string {
	cmd := exec.Command("niri", "msg", "--json", "workspaces")
	out, err := cmd.Output()
	if err != nil {
		return `{"text":"Error","tooltip":"Cannot connect to niri"}`
	}

	var workspaces []Workspace
	if err := json.Unmarshal(out, &workspaces); err != nil {
		return `{"text":"Error","tooltip":"Failed to parse workspaces"}`
	}

	if len(workspaces) == 0 {
		return `{"text":"1","tooltip":"Workspace 1"}`
	}

	// Sort by ID
	sort.Slice(workspaces, func(i, j int) bool {
		return workspaces[i].ID < workspaces[j].ID
	})

	// Store IDs for click handling
	workspaceIDs = make([]int, len(workspaces))
	for i, ws := range workspaces {
		workspaceIDs[i] = ws.ID
	}

	// Find active workspace
	activeID := -1
	for _, ws := range workspaces {
		if ws.IsFocused {
			activeID = ws.ID
			break
		}
	}
	if activeID == -1 {
		for _, ws := range workspaces {
			if ws.IsActive {
				activeID = ws.ID
				break
			}
		}
	}

	var textParts []string
	var tooltipParts []string

	for i, ws := range workspaces {
		displayNum := i + 1
		if ws.ID == activeID {
			// Active: orange highlight with pill background
			textParts = append(textParts, fmt.Sprintf(`<span color="#FFC799">%d</span>`, displayNum))
			tooltipParts = append(tooltipParts, fmt.Sprintf("● Workspace %d (active)", displayNum))
		} else {
			// Inactive: dim gray
			textParts = append(textParts, fmt.Sprintf(`<span color="#505050">%d</span>`, displayNum))
			tooltipParts = append(tooltipParts, fmt.Sprintf("○ Workspace %d", displayNum))
		}
	}

	output := Output{
		Text:    strings.Join(textParts, `  `),
		Tooltip: strings.Join(tooltipParts, "\n"),
	}

	result, _ := json.Marshal(output)
	return string(result)
}

func main() {
	// Initial output
	fmt.Println(getWorkspaces())

	// Listen for events
	cmd := exec.Command("niri", "msg", "--json", "event-stream")
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		os.Exit(1)
	}

	if err := cmd.Start(); err != nil {
		os.Exit(1)
	}

	scanner := bufio.NewScanner(stdout)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.Contains(line, "WorkspacesChanged") ||
			strings.Contains(line, "WorkspaceActivated") ||
			strings.Contains(line, "WorkspaceFocusChanged") {
			fmt.Println(getWorkspaces())
		}
	}

	cmd.Wait()
}