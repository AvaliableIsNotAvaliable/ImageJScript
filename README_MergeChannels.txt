Script language: Macro

This script is made for merging channels in imageJ/Fiji(up to 4 channels, including brightfield). 

How to use the script: 

    Open Fiji/ImageJ => Select "Plugins" in the menu => "Macros" => "Run..." or "Edit..." (=> click "Run" on the bottom if you choose "Edit..." in the previous step) 

Some points in this script: 

1. Select folder: select the folder which contains all your images needed to be merged, do not put other files in the folder. 

2. How to move images from some subfolders into one folder: 


   Example command for move images into one folder in windows: 

     for /r "F:\FOLDERPATH" %d in (*.TIF) do copy "%d" "F:\FOLDERPATH\"

   Or just use file explorer to search *.TIF, select all raw files and move to another folder.

   Only move raw images, don't put other images in the same folder. 


3. Every time you run the script, it will cover merged images created last time, if they have the same name. 

4. You can delete some unnecessary code in the script, such as showMessage(...). 

5. Always check merge folder after merged. 


============================================== Update in version 2 ===================================================

If numbers of images are not the same in different channels, it will give a message and stop merging. 

Example:

    Channel 1: 10 images
    Channel 2: 12 images  --> Here 2 more images than other channels
    Channel 3: 10 images

There should be a message "Some Images are missing! Please check!"

============================================== Update in version 2.1 ===================================================

The updated function in version 2 didn't work well, so I deleted the function. 

Now there is no notification if numbers of images in different channels are not the same. You have to count them manually. 


