Multispectral Indices Extraction Project

This project consists of several scripts and files designed for the extraction of multispectral indices and the creation of masks for the selection of regions of interest (ROI). It is composed of three main files:

1. community_ROI_selection.ijm (ImageJ Macro for ROI Mask Creation)
Description: This macro is used to create ROI (Region of Interest) masks that will later be used in the extraction process.
Functionality:
Creates masks for selecting regions of interest (ROIs) based on study areas.
Produces a general mask that can be used in the extraction.ijm process.
Usage:
Run this macro in ImageJ to define ROI masks before running the data extraction macro.
The created mask will be used later in the extraction process.

2.Species_ROI_selection.ijm
Description: This macro is used to create ROI (Region of Interest) masks for specific species that will later be used in the extraction process.
Functionality:
Creates masks for selecting regions of interest (ROIs) based on species.
Usage:
Run this macro in ImageJ to define ROI masks before running the data extraction macro.
The created mask will be used later in the extraction process.

3. extraction.ijm (ImageJ Macro for Band Value Extraction)
Description: This file contains a macro for ImageJ that extracts spectral band values from multispectral images.
Functionality:
The macro automates the process of extracting pixel values from single bands.
Once a species-specific ROI mask is created, it is used to gather pixel-by-pixel values of individual bands.
Usage:
Use this file in ImageJ to perform the extraction of band values from multispectral images.
The ROIs need to be defined and applied beforehand.

4. R_script.R
Description: This R script calculates a variety of multispectral indices based on single-band values.
Functionality:
Imports an Excel file containing the spectral band values.
Computes multispectral indices such as NDVI, GNDVI, RVI, SR, NDWI, NDWI2, NDMI, SAVI, EVI, PRI, VARI, CVI, CIgreen, CIred_edge, MCARI.
Exports the results to an Excel file.
Usage:
Make sure you have the Excel file with spectral band data ready.
The script performs the necessary transformations to extract the various indices.
Specify the output path to save the resulting file.

Requirements
R with the following packages:
readxl
dplyr
openxlsx

ImageJ to run .ijm macros

General Instructions
Create ROI masks: Use the community_ROI_selection.ijm macro in ImageJ to create ROI masks and Species_ROI_selection.ijm for different species.
Extract band values: Use the extraction.ijm macro in ImageJ to extract band values using the defined ROIs.
Calculate multispectral indices: Run the R script script_R_multispectral_indices.R to calculate the multispectral indices and save the results.

Author
Trotta Giacomo and Marco Vuerich

contact details:
giacomo.trotta@uniud.it

This README provides instructions and details for the correct usage of each file in your project.
