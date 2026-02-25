# SocialLoafing_FINAL
This is the final repository for the course "Empirisch-psychologisches Praktikum" of 2025/2026. Author: Samuel Riess

As a first step, you should open the project "Social_Loafing_FINAL" in RStudio to set the working directory exactly to the project folder (it makes the work easier later on). 
Please make sure you have downloaded all the necessary packages that are required for R and Quarto so run the manuscript properly. 
To ensure that, open the File "Report_Final" and check for a warning - there should be an "install" button you have to push and then the 
required files start downloading. 
Without em, you can't run the Quarto document and in addition no pdf will be rendered  from it. 

After doing that, you can Render the Quarto-Document to get the final Report in the pdf-format.

Short guide throughout the folder structure: 
- subfolder _extensions: these are necessary to render the Quarto document into a pdf that fits the APA7 citation and format requirements
- subfolder Base_literature: here you will find alle the literature this report is based on. 
  furthermore, the "references.bib" file containts all the literature, so it can be citated in the final report. It should be linked to the other documents
- subfolder "simulation": in this folder lays the code for our simulation and formalized theory and model. These documents are sourced in the Quarto document aswell, so you don't have to run em separately
- subfolder "doc": the VAST Displays and Graphics that are used in the process of writing the repost can be found here. The plots of the simulation are found in the final report for they are directly rendered 
  throughout the Quarto document
You can ignore the rest of the files in the project folder,  for they necessary to run the other documents, but do not include extra information that is crucial for the report itself. 

The final report can be seen in the pdf-file, that is rendered after running the whore Quarto document. It has the same name as the Quarto file, but with the appendix ".pdf". It should open
autonomously after running the Quarto file. 

The author information can be found in 2 places: 
- The YAML Header of the Quarto document 
- The Main Front page of the final .pdf file (the information from the YAML header goes straight here)

