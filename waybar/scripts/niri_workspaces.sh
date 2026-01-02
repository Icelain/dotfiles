#!/bin/bash

# Function to get and format workspace info
get_workspaces() {
    local workspaces
    workspaces=$(niri msg --json workspaces 2>/dev/null)

    if [ $? -ne 0 ] || [ -z "$workspaces" ]; then
        echo '{"text":"Error","tooltip":"Cannot connect to niri"}'
        return
    fi

    # Get active workspace ID
    local active_id
    active_id=$(echo "$workspaces" | jq -r '.[] | select(.is_focused == true) | .id' 2>/dev/null | head -1)

    if [ -z "$active_id" ]; then
        active_id=$(echo "$workspaces" | jq -r '.[] | select(.is_active == true) | .id' 2>/dev/null | head -1)
    fi

    # Get workspace IDs sorted
    local ids
    ids=$(echo "$workspaces" | jq -r '.[].id' 2>/dev/null | sort -n)

    if [ -z "$ids" ]; then
        echo '{"text":"1","tooltip":"Workspace 1"}'
        return
    fi

    local output=""
    local tooltip=""
    local first=true
    local display_num=1

    for id in $ids; do
        if [ "$first" = false ]; then
            output+=' <span color="#333333">│</span> '
            tooltip+="\n"
        fi
        first=false

        if [ "$id" = "$active_id" ]; then
            output+="<span color=\"#ffc799\" weight=\"700\">$display_num</span>"
            tooltip+="▶ Workspace $display_num (active)"
        else
            output+="<span color=\"#888888\">$display_num</span>"
            tooltip+="  Workspace $display_num"
        fi

        ((display_num++))
    done

    # Escape for JSON
    output_escaped="${output//\\/\\\\}"
    output_escaped="${output_escaped//\"/\\\"}"
    tooltip_escaped="${tooltip//\\/\\\\}"
    tooltip_escaped="${tooltip_escaped//\"/\\\"}"
    tooltip_escaped="${tooltip_escaped//$'\n'/\\n}"

    echo "{\"text\":\"${output_escaped}\",\"tooltip\":\"${tooltip_escaped}\"}"
}

# Initial output
get_workspaces

# Listen for workspace events and update on changes
niri msg --json event-stream 2>/dev/null | while read -r line; do
    if echo "$line" | jq -e '.WorkspacesChanged or .WorkspaceActivated or .WorkspaceFocusChanged' &>/dev/null; then
        get_workspaces
    fi
done