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

while true; do
    echo "-----------------"
    echo " Todo List Tool  "
    echo "-----------------"
    echo "1. List all tasks"
    echo "2. Display all tasks"
    echo "3. Add a task"
    echo "4. Display tasks by status(todo)"
    echo "5. Display tasks by status(doing)"
    echo "6. Display tasks by status(complete)"
    echo "7. Mark a task as complete"
    echo "8. Delete a task"
    echo "9. Exit"

    read -p "Enter your choice: " choice

case $1 in
        1)
            display_by_status 0
          ;;
        2)
            displayTask
          ;;
        3)
            shift
            add_task "$*"
          ;;
        4)
           display_by_status 0
          ;;
        5)
           display_by_status 1
          ;;
        6)
           display_by_status 2
          ;;
        7)
        read -p "Enter task serial number(s) to mark as complete (space separated): " serial_numbers
           shift
           if [[ $serial_numbers -gt 0 && $serial_numbers -le 8 ]];then
           mark_as_complete "$serial_numbers"
           else
                   echo "Error: You must provide between 1 and 8 serial number"
          fi
          ;;
        8)
        read -p "Enter task serial number(s) to mark as complete (space separated): " serial_numbers
           shift
           if [[ $serial_numbers -gt 0 && $serial_numbers -le 8 ]]; then
              delete_task "$serial_numbers"
           else
                   echo "Error: You must provide b/w 1 and 8 serial number"
           fi
          ;;
        9)
           echo "Exiting..."
           exit 0
          ;;
        *)
           echo "Error; Invalid Argument , Please Enter valid"
          ;;
esac
done