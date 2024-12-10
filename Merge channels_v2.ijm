// Get folder name and image names, create new folder to store merged images
dir = getDirectory("Select A Folder");
fileList = getFileList(dir);
merged_dir = dir + File.separator + "Merged_Images"
File.makeDirectory(merged_dir);


// Example command for move images into one folder in windows: 

// for /r "F:\FOLDERPATH" %d in (*.TIF) do copy "%d" "F:\FOLDERPATH\"

// Or just use file explorer to search: *.TIF, select all files and move to another folder

// Only move raw images, don't put other images in the same folder

showMessage("Please Move All Images Into One Folder\nExample methods given in script and readme file");


// Ask user to copy keywords of channels, keywords should be unique in image names. 
// If keywords are not in the last part of image names, it will give errors. 
// Ask users to modify image names or change codes by themselves. I don't want to add complex regular expression to match keywords in filenames here. (But it is possible if someone asks.)
// Exmaple: 
// image name: ABCDEFG_2020256_001 -> keyword: _001    ABCD_RED_20210178 -> Not ok in this version.
Dye = newArray("","red", "green", "blue", "gray", "cyan", "magenta", "yellow");
Dialog.create("Select_Your_Channels");	// Probably some people ask why add some underscores in these strings, it's because it always gives errors when no underscores. 
	//
	Dialog.addMessage("Only modify those channels with dyes");
	Dialog.addMessage("Keywords should be at the end of filenames! ");
	Dialog.addMessage("Exmaple:\nimage name: ABCDEFG_20200569_001 -> keyword: _001 or 001");
	Dialog.addMessage(" ");
	Dialog.addChoice("Channel_1_Dye", Dye, Dye[0]);
	Dialog.addString("Channel_1_Keyword", "");
	Dialog.addMessage(" ");
	
	Dialog.addChoice("Channel_2_Dye", Dye, Dye[0]);
	Dialog.addString("Channel_2_Keyword", "");
	Dialog.addMessage(" ");
	
	Dialog.addChoice("Channel_3_Dye", Dye, Dye[0]);
	Dialog.addString("Channel_3_Keyword", "");
	Dialog.addMessage(" ");
	
	Dialog.addChoice("Channel_4_Dye", Dye, Dye[0]);
	Dialog.addString("Channel_4_Keyword", "");
	Dialog.addMessage(" ");
Dialog.show();

channel1_dye = Dialog.getChoice();
channel2_dye = Dialog.getChoice();
channel3_dye = Dialog.getChoice();
channel4_dye = Dialog.getChoice();

for (i = 0; i < 8; i++) {
	if (endsWith(Dye[i], channel1_dye)) {
		channel1_dye = i;
	}
	if (endsWith(Dye[i], channel2_dye)) {
		channel2_dye = i;
	}
	if (endsWith(Dye[i], channel3_dye)) {
		channel3_dye = i;
	}
	if (endsWith(Dye[i], channel4_dye)) {
		channel4_dye = i;
	}
}
print(channel1_dye);

channel1_keyword = Dialog.getString();
channel2_keyword = Dialog.getString();
channel3_keyword = Dialog.getString();
channel4_keyword = Dialog.getString();
//print(channel4_keyword);

ImageChannel1 = channel1_keyword + ".TIF";
//print(ImageChannel1);
ImageChannel2 = channel2_keyword + ".TIF";
ImageChannel3 = channel3_keyword + ".TIF";
ImageChannel4 = channel4_keyword + ".TIF";
//print(ImageChannel4);

Image1_name = newArray(" ");
Image2_name = newArray(" ");
Image3_name = newArray(" ");
Image4_name = newArray(" ");


for (i = 0; i < lengthOf(fileList); i++) {
	if (endsWith(fileList[i], ImageChannel1)){
		Image1_name = Array.concat(Image1_name,fileList[i]); 
	}
	if (endsWith(fileList[i], ImageChannel2)) {
		Image2_name = Array.concat(Image2_name,fileList[i]); 
	}
	if (endsWith(fileList[i], ImageChannel3)) {
		Image3_name = Array.concat(Image3_name,fileList[i]); 
	}
	if (endsWith(fileList[i], ImageChannel4)) {
		Image4_name = Array.concat(Image4_name,fileList[i]); 
	}
	
}

//print(lengthOf(Image4_name));  //strange length, but just leave it away

if (channel2_keyword == ""){
	showMessage("Please choose at least 2 channels");
}

if (channel1_keyword == ""){
	showMessage("Please choose at least 2 channels");
}

showMessage("Start Merging");

if (channel3_keyword == "") {
	
	if (Image1_name.length == Image2_name.length) {
		
	}
		for (i = 0; i < Image1_name.length-1; i++) {
			//print(dir+Image1_name[i+1]);
			
			open(dir+Image1_name[i+1]);
			open(dir+Image2_name[i+1]);
			
			run("Merge Channels...", 
			"c"+channel1_dye + "=[" + Image1_name[i+1] + "] " + "c"+ channel2_dye + "=[" + Image2_name[i+1] + "] " + "create keep");
			selectImage("Composite");
			MergedName = substring(Image1_name[i+1], 0, lastIndexOf(Image1_name[i+1], channel1_keyword));
			//print(MergedName);
			selectWindow("Composite");
			saveAs("tif", merged_dir + File.separator + MergedName + "Merged");
			selectWindow(MergedName + "Merged.tif");
			run("RGB Color");
			saveAs("tif", merged_dir + File.separator + MergedName + "RGB");
			run("Close All");
		
	} else {
		
			showMessage("Some Images are missing! \nPlease check!");
		}
	

}


if (channel4_keyword == "" && channel3_keyword != "") {
	
	//if (Image1_name.length == Image3_name.length) && (Image2_name.length == Image3_name.length){
	//if ((Image1_name.length == Image3_name.length) == Image2_name.length){
	for (i = 0; i < Image1_name.length-1; i++) {
			open(dir+Image1_name[i+1]);
			open(dir+Image2_name[i+1]);
			open(dir+Image3_name[i+1]);
			//print(channel3_dye);
			run("Merge Channels...", 
			"c"+channel1_dye + "=[" + Image1_name[i+1] + "] " + "c"+ channel2_dye + "=[" + Image2_name[i+1] + "] " + "c"+ channel3_dye + "=[" + Image3_name[i+1] + "] " +  "create keep");
			selectImage("Composite");
			MergedName = substring(Image1_name[i+1], 0, lastIndexOf(Image1_name[i+1], channel1_keyword));
			//print(MergedName);
			selectWindow("Composite");
			saveAs("tif", merged_dir + File.separator + MergedName + "Merged");
			selectWindow(MergedName + "Merged.tif");
			run("RGB Color");
			saveAs("tif", merged_dir + File.separator + MergedName + "RGB");
			run("Close All");
		
	//} else {
		//	showMessage("Some Images are missing! \nPlease check!");
		}
	

}


if (channel4_keyword != "") {
	
	//if (((Image1_name.length == Image2_name.length) && Image2_name.length) == Image3_name.length && Image1_name.length == Image4_name.length ) {
			open(dir+Image1_name[i+1]);
			open(dir+Image2_name[i+1]);
			open(dir+Image3_name[i+1]);
			open(dir+Image4_name[i+1]);
			run("Merge Channels...", 
			"c"+channel1_dye + "=[" + Image1_name[i+1] + "] " + "c"+ channel2_dye + "=[" + Image2_name[i+1] + "] " + "c"+ channel3_dye + "=[" + Image3_name[i+1] + "] " + "c"+ channel4_dye + "=[" + Image4_name[i+1] + "] " + "create keep");
			selectImage("Composite");
			MergedName = substring(Image1_name[i+1], 0, lastIndexOf(Image1_name[i+1], channel1_keyword));
			//print(MergedName);
			selectWindow("Composite");
			saveAs("tif", merged_dir + File.separator + MergedName + "Merged");
			selectWindow(MergedName + "Merged.tif");
			run("RGB Color");
			saveAs("tif", merged_dir + File.separator + MergedName + "RGB");
			run("Close All");
		
	//} else {
	//		showMessage("Some Images are missing! \nPlease check!");
	//	}
	

}
	showMessage("Finished!\nPlease check your merge folder");






