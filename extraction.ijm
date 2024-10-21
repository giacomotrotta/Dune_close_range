#Macro for ImageJ to estract single band value#
dir1 = "Your path";

blocco = newArray("A","B","C","D","E","F","G","H"); //
	
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

			list = getFileList(dir1 + blocco[b] + "/ROI/");
			open(dir1 + blocco[b] + "/" + blocco[b] + "_" + c + "_stack.tif");
			for (m = 1; m <= 5; m++) {
				for (i = 0; i < list.length; i++) {
				
					Stack.setSlice(m); 
					if(startsWith(list[i], blocco[b] + "_" + c)){
						open(dir1 + blocco[b] + "/ROI/" + list[i]);
						run("Measure"); //be sure to have set the measurment you want through the set measurment setting
						} else {
						i = i + 1;
						}
					} 

				}
			selectImage(blocco[b] + "_" + c + "_stack.tif");
			run("Close");
			}
				
		}
		
