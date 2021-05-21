title_1=File.openDialog("Choose GFP file");
open(title_1);
dir_GFP=File.getParent(title_1)+File.separator;
name_GFP=File.nameWithoutExtension();
print(dir_GFP+name_GFP+".xls");
run("16-bit");
run("Despeckle");

title_2=File.openDialog("Choose RFP file");
open(title_2);
dir_mC=File.getParent(title_2)+File.separator;
name_mC=File.nameWithoutExtension();
print(dir_mC+name_mC+".xls");
run("16-bit");
run("Despeckle");

run("Images to Stack", "name=Stack title=[] use");
run("Align slices in stack...");
selectWindow("Results");
IJ.renameResults("alignment clutter");
run("Close");

setSlice(2);
run("Set Measurements...", "mean centroid redirect=None decimal=3");
setTool("multipoint");
waitForUser("Please click on every nuclear signal to be measured, one per cell (zoom with + and - keys after selecting image)...");
getSelectionCoordinates(xpoints, ypoints);
setSlice(1)
radius=1;
  	for (i=0; i<lengthOf(xpoints); i++) {
    		makeOval(xpoints[i]-radius, ypoints[i]-radius, 2*radius, 2*radius);
    		roiManager("Add");
  	}
setSlice(1);
roiManager("Measure");
updateResults();
selectWindow("Results");
saveAs("Results",dir_GFP+name_GFP+" GFP signal"+".xls");
//run("Close");
selectWindow("Results");
run("Close");
setSlice(2);
roiManager("Measure");
updateResults();
selectWindow("Results");
saveAs("Results",dir_mC+name_mC+" RFP signal"+".xls");
run("Close");
run("Close All");
roiManager("Reset");