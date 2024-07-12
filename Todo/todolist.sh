#!/bin/bash

FILE="todo.txt"
if [[ ! -f $FILE ]];then
        echo "File not found"
        exit 1
fi

display_by_status(){
        local status1="$1"
        awk -v status="$status1" '$3 == status{ print $0}' "$FILE"
}

displayTask(){
         awk '{ print $0}' "$FILE"
}
add_task(){
        local TASK=$1
        local serial=$(($(wc -l < $FILE)+1))
        echo "$serial $TASK 0">>$FILE
        echo "Task added Successfully!"

}
mark_as_complete() {
    local serials=("$@")
    local temp_file=$(mktemp)
    while read -r line; do
        local serial=$(echo "$line" | awk '{print $1}')
        if [[ " ${serials[@]} " =~ " $serial " ]]; then
            echo "$(echo "$line" | awk '{$3=2; print $0}')" >> "$temp_file"
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$FILE"
    mv "$temp_file" "$FILE"
    echo "Task(s) marked as complete!"
}

delete_task() {
    local serials=("$@")
    local temp_file=$(mktemp)
    while read -r line; do
        local serial=$(echo "$line" | awk '{print $1}')
        if [[ ! " ${serials[@]} " =~ " $serial " ]]; then
            echo "$line" >> "$temp_file"
        fi
    done < "$FILE"
    mv "$temp_file" "$FILE"
    echo "Task(s) deleted!"
}
case $1 in
        "")
            display_by_status 0
          ;;
        display)
            displayTask
          ;;
        add)
            shift
            add_task "$*"
          ;;
        todo)
           display_by_status 0
          ;;
        doing)
           display_by_status 1
          ;;
        complete)
           display_by_status 2
          ;;
        mark_complete)
           shift
           if [[ $# -gt 0 && $# -le 8 ]];then
           mark_as_complete "$*"
           else
                   echo "Error: You must provide between 1 and 8 serial number"
          fi
          ;;
        delete)
           shift
           if [[ $# -gt 0 && $# -le 8 ]]; then
              delete_task "$*"
           else
                   echo "Error: You must provide b/w 1 and 8 serial number"
           fi
          ;;
        *)
           echo "Error; Invalid Argument , Please Enter valid"
          ;;
esac
