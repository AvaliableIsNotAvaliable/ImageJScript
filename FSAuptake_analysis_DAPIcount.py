import os
import pandas as pd
import glob


def find_txt(dir, keyword): 
    # Use glob to recursively find all text files with the keyword in their filenames
    pattern = os.path.join(dir, '**', f'*{keyword}*.txt')
    files = glob.glob(pattern, recursive=True)
    return files


def count_rows(files):
    file_row_counts = {}
    for file_path in files:
        with open(file_path, 'r', encoding='utf-8') as file:
            # Count the number of rows (lines) in the file
            row_count = sum(1 for _ in file)
            file_row_counts[file_path] = row_count
    return file_row_counts
    
def results(file_row_counts, output_file):
    df = pd.DataFrame(list(file_row_counts.items()), columns=['file name', 'row counts'])
    df.to_csv(output_file, index = False)
    
def main():
    dir = "/mnt/d/LIVR/4. DLPC/Raw Data/mLSEC_TestDLPC_D2_D6_20240822/mLSEC_FSA_uptake/DAPI_results"
    keyword = 'DAPI'
    output_file = "/mnt/d/LIVR/4. DLPC/Raw Data/mLSEC_TestDLPC_D2_D6_20240822/mLSEC_FSA_uptake/DAPI_row_counts.csv"

    files = find_txt(dir, keyword)

    if not files:
        print(f"No files found with the keyword")
        return
    
    # Count the number of rows in each file
    file_row_counts = count_rows(files)

    # Print the results
    results(file_row_counts, output_file)
    print(f"Stored")

if __name__ == '__main__':
    main()
