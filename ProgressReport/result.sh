#!/bin/bash

# Function to check if roll number already exists
check_duplicate_roll_no() {
    local roll_no=$1
    if grep -q "^$roll_no " data.txt; then
        return 1
    else
        return 0
    fi
}

# Function to add a student record
add_student() {
    while true; do
        echo "Enter Roll Number (4 digits):"
        read roll_no
        if [[ $roll_no =~ ^[0-9]{4}$ ]]; then
            if check_duplicate_roll_no $roll_no; then
                break
            else
                echo "Roll Number already exists. Please enter a different Roll Number."
            fi
        else
            echo "Invalid Roll Number. Please enter a 4-digit number."
        fi
    done

    echo "Enter Name:"
    read name

    while true; do
        echo "Enter Marks in History (0-100):"
        read history
        if [[ $history =~ ^[0-9]$|^[1-9][0-9]$|^100$ ]]; then
            break
        else
            echo "Invalid Marks. Please enter a number between 0 and 100."
        fi
    done

    while true; do
        echo "Enter Marks in Geography (0-100):"
        read geography
        if [[ $geography =~ ^[0-9]$|^[1-9][0-9]$|^100$ ]]; then
            break
        else
            echo "Invalid Marks. Please enter a number between 0 and 100."
        fi
    done

    while true; do
        echo "Enter Marks in Civics (0-100):"
        read civics
        if [[ $civics =~ ^[0-9]$|^[1-9][0-9]$|^100$ ]]; then
            break
        else
            echo "Invalid Marks. Please enter a number between 0 and 100."
        fi
    done

    echo "$roll_no $name $history $geography $civics" >> data.txt
    echo "Student record added."
}



# Function to print students with passing marks
print_passing_students() {
    echo "Students with passing marks (>=33 in each subject):"
    while read -r line; do
        roll_no=$(echo $line | awk '{print $1}')
        name=$(echo $line | awk '{print $2}')
        history=$(echo $line | awk '{print $3}')
        geography=$(echo $line | awk '{print $4}')
        civics=$(echo $line | awk '{print $5}')

        if [[ $history -ge 33 && $geography -ge 33 && $civics -ge 33 ]]; then
            echo "$roll_no $name"
        fi
    done < data.txt
}

# Function to print students with their divisions
print_students_with_divisions() {
    echo "Students with their divisions:"
    while read -r line; do
        roll_no=$(echo $line | awk '{print $1}')
        name=$(echo $line | awk '{print $2}')
        history=$(echo $line | awk '{print $3}')
        geography=$(echo $line | awk '{print $4}')
        civics=$(echo $line | awk '{print $5}')

        total_marks=$((history + geography + civics))
        avg_marks=$((total_marks / 3))

        if [[ $history -ge 33 && $geography -ge 33 && $civics -ge 33 ]]; then
            if [[ $avg_marks -ge 75 ]]; then
                division="Ist division"
            elif [[ $avg_marks -ge 60 ]]; then
                division="IInd division"
            else
                division="IIIrd division"
            fi
        else
            division="Fail"
        fi

        echo "$roll_no $name $division"
    done < data.txt
}

# Function to delete a student record
delete_student() {
    echo "Enter Roll Number to delete:"
    read roll_no

    if grep -q "^$roll_no " data.txt; then
        grep -v "^$roll_no " data.txt > temp.txt && mv temp.txt data.txt
        echo "Student record deleted."
    else
        echo "Roll Number not found."
    fi
}






# Menu loop
while true; do
    echo "Menu:"
    echo "1. Add a student record"
    echo "2. Print the list of students above passing marks (>=33 in each subject)"
    echo "3. Print the list of students with their divisions"
    echo "4. Delete a student record"
    echo "5. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        1)
            add_student
            ;;
        2)
            print_passing_students
            ;;
        3)
            print_students_with_divisions
            ;;
        4)
            delete_student
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done

