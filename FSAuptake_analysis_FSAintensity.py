import os
import pandas as pd
import glob
import csv


def find_txt(dir, keyword): 
    # Use glob to recursively find all text files with the keyword in their filenames
    pattern = os.path.join(dir, '**', f'*{keyword}*.txt')
    files = glob.glob(pattern, recursive=True)
    return files

def read_second_rows_from_files(files):
    second_rows = []
    for file_path in files:
        with open(file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()
            # Check if the file has at least two lines
            if len(lines) >= 2:
                second_rows.append(lines[1].strip())
            else:
                second_rows.append('')  # Handle case where there is no second row
    return second_rows

def write_to_csv(contents, output_file):
    # Open the output CSV file
    with open(output_file, 'w', newline='', encoding='utf-8') as csvfile:
        csv_writer = csv.writer(csvfile)
        
        # Write the contents to the CSV file
        for file_content in contents:
                csv_writer.writerow([file_content])
    
def main():
    dir = "dir1"
    keyword = 'FSA'
    output_file = "dir2"
    files = find_txt(dir, keyword)

    if not files:
        print(f"No files found with the keyword")
        return
    
    # Count the number of rows in each file
    second_rows = read_second_rows_from_files(files)

    # Print the results
    write_to_csv(second_rows, output_file)
    print(f"Stored")

if __name__ == '__main__':
    main()
