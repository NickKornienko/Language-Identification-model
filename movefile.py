import os
import shutil
from tqdm import tqdm

def organize_files(folder_path, files_per_subfolder=100):
    # List all files in the folder
    files = [f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))]
    
    # Determine the number of subfolders needed
    total_files = len(files)
    num_subfolders = total_files // files_per_subfolder + (1 if total_files % files_per_subfolder else 0)
    
    # Create subfolders and move files
    for i in tqdm(range(num_subfolders)):
        # Create a subfolder
        subfolder_name = os.path.join(folder_path, f'subfolder_{i+1}')
        os.makedirs(subfolder_name, exist_ok=True)

        # Move files into the subfolder
        for f in files[i*files_per_subfolder:(i+1)*files_per_subfolder]:
            shutil.move(os.path.join(folder_path, f), subfolder_name)

# Usage
folder_path =[]
folder_path.append(r'C:\Users\neel2\Code\data\data255\english')
folder_path.append(r'C:\Users\neel2\Code\data\data255\spanish')
folder_path.append(r'C:\Users\neel2\Code\data\data255\french')  # Replace with the path to your folder
for folder in folder_path:
	organize_files(folder)
