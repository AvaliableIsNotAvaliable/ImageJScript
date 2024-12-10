// Get folder name and image names, create new folder to store merged images
dir = getDirectory("Select A Folder");
fileList = getFileList(dir);
merged_dir = dir + File.separator + "Merged_Images"
File.makeDirectory(merged_dir);


// Ask user to copy keywords of channels, keywords should be unique in image names. 
// If keywords are not in the last part of image names, it will give errors. Ask user to modify image names or change codes by themselves.
// Exmaple: 
// image name: ABCDEFG_2020256_001 -> keyword: _001    ABCD_RED_20210178 -> Not ok in this version.
//ChannelChoice = newArray("Red", "Green", "Blue");
Dialog.create("IMPORTANT");
	Dialog.addMessage("Please_Move_All_Images_In_One_Folder");
	Dialog.addMessage("Example_method_Given_In_Script");
Dialog.show();

// Example command for move images into one folder: 
// for /r "F:\FOLDERPATH" %d in (*.TIF) do copy "%d" "F:\FOLDERPATH\"
// Or just use file explorer to search: *.TIF, select all files and move to another folder
// Only move raw images, don't put other images as the same folder

// For BrightField, users can change the Channel name by themselves

Dialog.create("Channel_1_Setting");
	//Channel 1 setting
	Dialog.addMessage("RED_CHANNEL");
	Dialog.addMessage("Make_Sure_The_Keyword_Should_Be_Unique");
	Dialog.addString("The_Keyword_of_Your_Channel_1", "");
Dialog.show();
Keyword1 = Dialog.getString();

Dialog.create("Channel_2_Setting");
	//Channel 2 setting
	Dialog.addMessage("GREEN_CHANNEL");
	Dialog.addMessage("Make_Sure_The_Keyword_Should_Be_Unique");
	Dialog.addString("The_Keyword_of_Your_Channel_2", "");
	//Dialog.addChoice("Channel2", newArray("Red", "Green", "Blue"));
Dialog.show();
Keyword2 = Dialog.getString();

Dialog.create("Channel_3_Setting");
	//Channel 3 setting
	Dialog.addMessage("BLUE_CHANNEL");
	Dialog.addMessage("Make_Sure_The_Keyword_Should_Be_Unique");
	Dialog.addString("The_Keyword_of_Your_Channel_3", "");
	//Dialog.addChoice("Channel3", newArray("Red", "Green", "Blue"));
Dialog.show();
Keyword3 = Dialog.getString();



ImageChannel1 = Keyword1 + ".TIF";
//print(ImageChannel1);
ImageChannel2 = Keyword2 + ".TIF";
ImageChannel3 = Keyword3 + ".TIF";

Image1_name = newArray(" ");
Image2_name = newArray(" ");
Image3_name = newArray(" ");

for (i = 0; i < lengthOf(fileList); i++) {
	if (endsWith(fileList[i], ImageChannel1)) {
		Image1_name = Array.concat(Image1_name,fileList[i]); 
		//print(Image1_name[i]);
	}
	if (endsWith(fileList[i], ImageChannel2)) {
		Image2_name = Array.concat(Image2_name,fileList[i]); 
		//Image2_name = newArray(Image2_name, fileList[i]); 
		//Image2_name = fileList[i];
		//print(Image2_name[i]);
	}
	if (endsWith(fileList[i], ImageChannel3)) {
		Image3_name = Array.concat(Image3_name,fileList[i]); 
		//Image3_name = newArray(Image3_name, fileList[i]); 
		//Image3_name = fileList[i];
		//print(Image3_name[i]);
	}
}

for (i = 0; i < Image1_name.length-1; i++) {
	//print(dir+Image1_name[i+1]);
	open(dir+Image1_name[i+1]);
	open(dir+Image2_name[i+1]);
	open(dir+Image3_name[i+1]);
	run("Merge Channels...", 
	"c1=[" + Image1_name[i+1] + "] " + "c2=[" + Image2_name[i+1] + "] " + "c3=[" + Image3_name[i+1] + "] create keep");
	// Here users can change channels, c1 red, c2 green, c3 blue, c4 grey-brightfeild
	selectImage("Composite");
	MergedName = substring(Image1_name[i+1], 0, lastIndexOf(Image1_name[i+1], Keyword1));
	print(MergedName);
	selectWindow("Composite");
	saveAs("tif", merged_dir + File.separator + MergedName + "Merged");
	selectWindow(MergedName + "Merged.tif");
	run("RGB Color");
	saveAs("tif", merged_dir + File.separator + MergedName + "RGB");
	run("Close All");
}

Dialog.create("Finished");
	Dialog.addMessage("Merged_Finished");
Dialog.show();

