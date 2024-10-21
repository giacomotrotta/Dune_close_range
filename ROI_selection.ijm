dir1 = "your path input images";
output = "folder of output";
blocco = newArray("A","B","C","D","E","F","G","H"); //in our experiment we had 8 block named with the letter and 8 treatment plus 1 external reference for each block so for example we had plot A1, A2,...A9, B1... and so on

user_specified = getBoolean("What do you want to do?", "Automatic cycle", "Specify images");
if(user_specified==1){
	
	letter_for = newArray("A","B","C","D","E","F","G","H");
	number_for = newArray("1","2","3","4","5","6","7","8","9");
	Dialog.create("USER-DEFINED STARTING POINT");
	Dialog.addChoice("From where do you want to start? (letter):", letter_for);
	Dialog.addChoice("From where do you want to start? (number):", number_for);
	Dialog.show();
	letter_for = Dialog.getChoice();
	number_for = Dialog.getChoice();
	if(letter_for == "A"){letter_for = 0;}
	if(letter_for == "B"){letter_for = 1;}
	if(letter_for == "C"){letter_for = 2;}
	if(letter_for == "D"){letter_for = 3;}
	if(letter_for == "E"){letter_for = 4;}
	if(letter_for == "F"){letter_for = 5;}
	if(letter_for == "G"){letter_for = 6;}
	if(letter_for == "H"){letter_for = 7;}
	
	for (b=letter_for; b<8; b++) {
		for (c=number_for; c<10; c++) {
			blue = dir1 + blocco[b] + "/r5_" + blocco[b] + "_" + c + "_blue.tiff";
			green = dir1 + blocco[b] + "/r5_" + blocco[b] + "_" + c + "_green.tiff";
			red = dir1 + blocco[b] + "/r5_" + blocco[b] + "_" + c + "_red.tiff";
			r_edge = dir1 + blocco[b] + "/r5_" + blocco[b] + "_" + c + "_r_edge.tiff";
			nir = dir1 + blocco[b] + "/r5_" + blocco[b] + "_" + c + "_nir.tiff";
			//list = getFileList(path);
			//showProgress(b+1, list.length);
			open(blue);
			open(green);
			open(red);
			open(r_edge);
			open(nir);
			run("Images to Stack");
			waitForUser("Check the correct alignment");
			aligned_img=getBoolean("Images are aligned?");
			if(aligned_img == 0){
					//script only when blue band is with offset
					selectWindow("Stack");
					run("Close");
					open(r_edge);
					open(blue);
					run("Images to Stack");
					run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Affine interpolate");
					run("Stack to Images");
					selectWindow("Aligned-0001");
					run("Close");
					selectWindow("Log");
					run("Close");
					selectWindow("Stack");
					run("Close");
					selectWindow("Aligned-0002");
					saveAs("Tiff", dir1 + blocco[b] + "/r5_" + blocco[b] + "_" + c + "_blue.tiff");
					open(green);
					open(red);
					open(r_edge);
					open(nir);
					run("Images to Stack");
					waitForUser("Check the correct alignment");
				}
				run("Rotate... ");
				run("Set... ", "zoom=75");
				setTool("rectangle");
				waitForUser("Create rectangle (less edges as possible)");
				run("Crop");
				run("Set... ", "zoom=75");
				waitForUser("Set scale, pixel image size = 98cm ");
				run("Set Scale...");
				run("Set... ", "zoom=75");
				waitForUser("You will find the stack in the folder Imagej");
				name_stack = blocco[b] + "_" + c + "_stack.tif";
				run("Image Sequence... ", "dir=" + output + blocco[b] + "/ format=TIFF name=" + blocco[b] + "_" + c + "_");
				saveAs("Tiff", output + blocco[b] + "/" + name_stack);
				close();
				plant=getBoolean("Plant are present?");
				if(plant==1){
					open(output + blocco[b] + "/" + blocco[b] + "_" + c + "_0002.tif");
					open(output + blocco[b] + "/" + blocco[b] + "_" + c + "_0001.tif");
					open(output + blocco[b] + "/" + blocco[b] + "_" + c + "_0000.tif");
					run("Images to Stack", "use");
					run("16-bit");
					run("Stack to RGB");
					selectWindow("Stack");
					close();
					run("Brightness/Contrast...");
					waitForUser("Set AUTO Brightness, adjust and apply");
					selectWindow("B&C");
					run("Close");
					run("Color Threshold...");
					waitForUser("Color Threshold and select");
					run("Create Mask");
					selectWindow("Stack (RGB)");
					run("Select None");
					selectWindow("Threshold Color");
					run("Close");
					selectWindow("Mask");
					waitForUser("Shift mask image to use the preview");
					waitForUser("Select filter. Important: EDGES INCLUDED, Area of interest need to be white");
					selectWindow("Mask");
					run("Shape Filter");
					selectWindow("ROI Manager");
					run("Close");
					selectWindow("Results");
					run("Close");
					setForegroundColor(0, 0, 0);
					waitForUser("Select brush and delete wrong parts");
					selectWindow("Mask");
					run("Create Selection");
					saveAs("Selection", output + blocco[b] + "/" + blocco[b] + "_" + c + "_MASK.roi");
					run("ROI Manager...");
					// roiManager("Show All");
					roiManager("Show All with labels");
					do{
						setTool("freehand");
						waitForUser("Draw poligon of one species. REMEMBER in the next step to NOT consider holes");
						run("Analyze Particles...");
						waitForUser("Copy and paste");	
						loop_while=getBoolean("Other plant to select?");
						run("Select None");
			            } while(loop_while==1); 
			        selectWindow("ROI Manager");
					run("Close");
					selectWindow("Results");
					run("Close");
					selectWindow("Summary");
					run("Close");
			        selectWindow("Stack (RGB)");
					run("Close");
					selectWindow("Mask");
					run("Close");
				}
			
			number_for = 1;
		}
	}
}
if(user_specified==0){
	do{
		
		letter = newArray("A","B","C","D","E","F","G","H");
		number = newArray("1","2","3","4","5","6","7","8","9");
		Dialog.create("USER-DEFINED IMAGE");
		Dialog.addChoice("Which plot? (letter):", letter);
		Dialog.addChoice("Which plot? (number):", number);
		Dialog.show();
		letter = Dialog.getChoice();
		number = Dialog.getChoice();
		blue = dir1 + letter + "/r5_" + letter + "_" + number + "_blue.tiff";
		green = dir1 + letter + "/r5_" + letter + "_" + number + "_green.tiff";
		red = dir1 + letter + "/r5_" + letter + "_" + number + "_red.tiff";
		r_edge = dir1 + letter + "/r5_" + letter + "_" + number + "_r_edge.tiff";
		nir = dir1 + letter + "/r5_" + letter + "_" + number + "_nir.tiff";
		  
	    open(blue);
	    open(green);
		open(red);
		open(r_edge);
		open(nir);
		run("Images to Stack");
		run("Rotate... ");
		run("Set... ", "zoom=75");
		setTool("rectangle");
		waitForUser("Create rectangle (less edges as possible)");
		run("Crop");
		run("Set... ", "zoom=75");
		waitForUser("Set scale, pixel image size = 98cm ");
		run("Set Scale...");
		run("Set... ", "zoom=75");
		waitForUser("You will find the stack in the folder Imagej");
		name_stack = letter + "_" + number + "_stack.tif";
		run("Image Sequence... ", "dir=" + output + letter + "/ format=TIFF name=" + letter + "_" + number + "_");
		saveAs("Tiff", output + letter + "/" + name_stack);
		close();
		open(output + letter + "/" + letter + "_" + number + "_0002.tif");
		open(output + letter + "/" + letter + "_" + number + "_0001.tif");
		open(output + letter + "/" + letter + "_" + number + "_0000.tif");
		run("Images to Stack", "use");
		run("16-bit");
		run("Stack to RGB");
		selectWindow("Stack");
		close();
		run("Brightness/Contrast...");
		waitForUser("Set AUTO Brightness, adjust and apply");
		selectWindow("B&C");
		run("Close");
		run("Color Threshold...");
		waitForUser("Color Threshold and select");
		run("Create Mask");
		selectWindow("Stack (RGB)");
		run("Select None");
		selectWindow("Threshold Color");
		run("Close");
		selectWindow("Mask");
		waitForUser("Shift mask image to use the preview");
		waitForUser("Select filter. Important: EDGES INCLUDED, Area of interest need to be white");
		selectWindow("Mask");
		run("Shape Filter");
		selectWindow("ROI Manager");
		run("Close");
		selectWindow("Results");
		run("Close");
		setForegroundColor(0, 0, 0);
		waitForUser("Select brush and delete wrong parts");
		selectWindow("Mask");
		run("Create Selection");
		saveAs("Selection", output + letter + "/" + letter + "_" + number + "_MASK.roi");
		run("ROI Manager...");
		// roiManager("Show All");
		roiManager("Show All with labels");
		do{
			setTool("freehand");
			waitForUser("Draw poligon of one species. REMEMBER in the next step to NOT consider holes");
			run("Analyze Particles...");
			waitForUser("Copy and paste");	
			loop_while=getBoolean("Other plant to select?");
			run("Select None");
	        } while(loop_while==1); 
	    selectWindow("ROI Manager");
		run("Close");
		selectWindow("Results");
		run("Close");
		selectWindow("Summary");
		run("Close");
	    selectWindow("Stack (RGB)");
		run("Close");
		selectWindow("Mask");
		run("Close");
		user_continue = getBoolean("What do you want to do?", "Stop image processing", "Do another image");	  	
	} while(user_continue==0)
}
