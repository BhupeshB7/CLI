#!/bin/bash

# Function to list files with various options
list_files() {
    echo "Listing files in $(pwd):"
    echo "1. List all files"
    echo "2. List hidden files"
    echo "3. List files in human-readable format"
    echo "4. Detailed file information"
    read -p "Enter your choice: " list_choice

    case $list_choice in
        1) ls -l ;;
        2) ls -la ;;
        3) ls -lh ;;
        4) detailed_file_info ;;
        *) echo "Invalid choice." ;;
    esac
}

# Function to display detailed file information
detailed_file_info() {
    echo "Enter filename:"
    read filename
    stat "$filename"
}

# Function to analyze file types
file_type_analysis() {
    echo "File type analysis:"
    echo "1. Count text files"
    echo "2. Count image files"
    read -p "Enter your choice: " type_choice

    case $type_choice in
        1) count_text_files ;;
        2) count_image_files ;;
        *) echo "Invalid choice." ;;
    esac
}

# Function to count text files
count_text_files() {
    echo "Text files count:"
    find . -type f -name "*.txt" | wc -l
}

# Function to count image files
count_image_files() {
    echo "Image files count:"
    find . -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | wc -l
}

# Function to calculate directory size
calculate_directory_size() {
    echo "Directory size calculation:"
    du -sh *
}

# Function to copy a file
copy_file() {
    echo "Enter source file:"
    read source_file
    echo "Enter destination directory:"
    read destination_dir
    cp "$source_file" "$destination_dir"
    echo "File copied successfully."
}

# Function to move a file
move_file() {
    echo "Enter source file:"
    read source_file
    echo "Enter destination directory:"
    read destination_dir
    mv "$source_file" "$destination_dir"
    echo "File moved successfully."
}

# Function to display detailed file permissions
detailed_file_permissions() {
    echo "Enter filename:"
    read filename
    ls -l "$filename"
}

# Main script
while true; do
    echo "----------------------"
    echo " File Management Tool "
    echo "----------------------"
    echo "1. List files"
    echo "2. File type analysis"
    echo "3. Calculate directory size"
    echo "4. Copy file"
    echo "5. Move file"
    echo "6. Detailed file permissions"
    echo "7. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1) list_files ;;
        2) file_type_analysis ;;
        3) calculate_directory_size ;;
        4) copy_file ;;
        5) move_file ;;
        6) detailed_file_permissions ;;
        7) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please enter a number between 1 and 7."
    esac
done
