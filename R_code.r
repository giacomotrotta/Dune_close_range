#load required library#
library(dplyr)
library(readxl)
library(openxlsx)

#importe Dataset#
Dataset_for_index <- read_excel("your data") #excel with your single band value
Dataset_for_index <- Dataset_for_index %>%
        mutate(
          NDVI = (NIR - R) / (NIR + R),
          GNDVI = (NIR - G) / (NIR + G),
          RVI = NIR / R,
          SR = NIR / R,
          NDWI = (G - NIR) / (G + NIR),
          NDWI2 = (NIR - B) / (NIR + B),
          NDMI = (NIR - EDGE) / (NIR + EDGE),
          SAVI = (1.5 * (NIR - R)) / (NIR + R + 0.5),
          EVI = 2.5 * (NIR - R) / (NIR + 6 * R - 7.5 * B + 1),
          PRI = (G - B) / (G + B),
          VARI = (G - R) / (G + R - B),
          CVI = NIR * (R / (G^2)),
          CIgreen = (NIR / G) - 1,
          CIred_edge = (NIR / EDGE) - 1,
          MCARI = ((R - G) / (R - B)) * NIR
        )

      file_path <- "your path for exportation"
      
      # Scrivi il dataset in un file Excel
      write.xlsx(Dataset_for_index, file = file_path, sheetName = "your file name", rowNames = FALSE)




