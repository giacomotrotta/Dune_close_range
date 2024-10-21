
input = "your folder with images";
blocco = newArray("A","B","C","D","E","F","G","H"); //in our experiment we had 8 block named with the letter and 8 treatment plus 1 external reference for each block so for example we had plot A1, A2,...A9, B1... and so on

user_specified = getBoolean("What do you want to do?", "Automatic cycle", "Specify images"); //to choose a specific image or an automatic cycle
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
					open(input + blocco[b] + "/" + blocco[b] + "_" + c + "_0002.tif"); //depending on the type of images you are using. In this case the micasense 0002 (RED), 0001 (Green) and 0000(blue) are chooseto obtain an rgb image
					open(input + blocco[b] + "/" + blocco[b] + "_" + c + "_0001.tif");
					open(input + blocco[b] + "/" + blocco[b] + "_" + c + "_0000.tif");
					getString("Plot", blocco[b] + "_" + c);
					run("Images to Stack", "use");
					run("16-bit");
					run("Stack to RGB");
					selectWindow("Stack");
					close();
					run("Brightness/Contrast...");
					waitForUser("Set AUTO Brightness, adjust and apply"); //to adjust the britghness and made the plant more visible
					selectWindow("B&C");
					run("Close");
					plant=getBoolean("Plant are present?");
					if(plant==1){
					
					selectWindow("Stack (RGB)");
					open(input + blocco[b] + "/" + blocco[b] + "_" + c + "_MASK.roi");
					run("Create Mask");
					selectWindow("Stack (RGB)");
					run("Select None");
					do{
						selectWindow("Mask");
						setTool("freehand");
						waitForUser("Draw poligon of one species.");
						run("Analyze Particles...", "  show=Masks composite");
						selectWindow("Mask of Mask");
						run("Invert LUT");
						species = newArray("Amar_retr", "Ambr_psil", "Atri_rose",	"Caki_mari",	"Cenc_long",	"Cusc_scan",	"Cyno_dact",	"Cype_capi",	"Cype_escu",	"Erig_cana",	"Lepi_virg",	"Lome_arge",	"Oeno_bien",	"Plan_aren",	"Pote_sang",	"Robi_pseu",	"Sals_kali",	"Sile_vulg",	"Soda_iner",	"Trac_vene",	"Xant_ital" );
						Dialog.create("USER-DEFINED SPECIES");
						Dialog.addChoice("Which species is the one masked?:", species);
						Dialog.show();
						species = Dialog.getChoice();
						selectWindow("Mask of Mask");
						run("Create Selection");
						saveAs("Selection", input + blocco[b] + "/" + blocco[b] + "_" + c + "_" + species + "_SINGLE_MASK.roi");
						loop_while=getBoolean("Other plant to select?");
						selectWindow("Mask");
						run("Select None");
						selectWindow("Mask of Mask");
						run("Close");
			            } while(loop_while==1); 
			          	selectWindow("Stack (RGB)");
						run("Close");  
						selectWindow("Mask");
						run("Close"); 
					}
					if(plant==0){
						selectWindow("Stack (RGB)");
						run("Close");
						}
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
		open(input + letter + "/" + letter + "_" + number + "_0002.tif");
		open(input + letter + "/" + letter + "_" + number + "_0001.tif");
		open(input + letter + "/" + letter + "_" + number + "_0000.tif");
		run("Images to Stack", "use");
					run("16-bit");
					run("Stack to RGB");
					selectWindow("Stack");
					close();
					run("Brightness/Contrast...");
					waitForUser("Set AUTO Brightness, adjust and apply");
					selectWindow("B&C");
					run("Close");
//roiManager("reset");
					
					selectWindow("Stack (RGB)");
					open(input + blocco[b] + "/" + blocco[b] + "_" + c + "_MASK.roi");
					run("Create Mask");
					selectWindow("Stack (RGB)");
					run("Select None");
					do{
						selectWindow("Mask");
						setTool("freehand");
						waitForUser("Draw poligon of one species.");
						run("Analyze Particles...", "  show=Masks composite");
						selectWindow("Mask of Mask");
						run("Invert LUT");
						species = newArray("Amar_retr", "Ambr_psil", "Atri_rose",	"Caki_mari",	"Cenc_long",	"Cusc_scan",	"Cyno_dact",	"Cype_capi",	"Cype_escu",	"Erig_cana",	"Lepi_virg",	"Lome_arge",	"Oeno_bien",	"Plan_aren",	"Pote_sang",	"Robi_pseu",	"Sals_kali",	"Sile_vulg",	"Soda_iner",	"Trac_vene",	"Xant_ital" );
						Dialog.create("USER-DEFINED SPECIES");
						Dialog.addChoice("Which species is the one masked?:", species);
						Dialog.show();
						species = Dialog.getChoice();
						selectWindow("Mask of Mask");
						run("Create Selection");
						saveAs("Selection", input + blocco[b] + "/" + blocco[b] + "_" + c + "_" + species + "_MASK.roi");
						loop_while=getBoolean("Other plant to select?");
						run("Select None");
						selectWindow("Mask of Mask");
						run("Close");
			            } while(loop_while==1); 	
						selectWindow("Stack (RGB)");
						run("Close");  	 
						user_continue = getBoolean("What do you want to do?", "Stop image processing", "Do another image");	 
							
	} while(user_continue==0)
}

