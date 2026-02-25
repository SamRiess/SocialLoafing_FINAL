# SocialLoafing_FINAL
This is the final repository for the course "Empirisch-psychologisches Praktikum" of 2025/2026. Author of the individual report: Samuel Riess

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

The final report can be seen in the pdf-file, that is rendered after running the whole Quarto document. It has the same name as the Quarto file, but with the appendix ".pdf". It should open
autonomously after running the Quarto file. 



#README-File for simplification of the reproducability of the studies results 

- title:  (insert title later on)
- authors: Samuel Riess (maybe add the other group members later on)
- Date of disposal: (add this later on)
- contact information: 
  Felix Schönbrodt (leader of the didactic course in which this project took place): felix.schönbrodt@psy.lmu.de
  Samuel Riess (author): Samuel.riess@campus.lmu.de

- instruction for the citation of this report: 
  This report was part of a didactic course at LMU Munich). Hence, no publication will follow and no citation is necessary.
  
- short description of the project: 
  (add this later on)
  (add Abstract here)
  
- 

# README-Dokument zur Vereinfachung der Reproduzierbarkeit der Ergebnisse

- Titel der Arbeit: Manipulation von Intimitätsmotivation mithilfe von Ecological Momentary Interventions
- Autoren: Felix Schönbrodt und Samuel Rieß
- Datum der Abgabe: 22.09.2024
- Kontaktinformation: 
  Felix Schönbrodt (Email): felix.schönbrodt@psy.lmu.de
  Samuel Rieß (Email): samuel.riess@campus.lmu.de

- structure of the project folder: 
  - the R Scripts for the simulation can be fond in the subfolder /simulation
  - the library for citations is included in the /Base_Literature folder
  - the final report can be created from the Quarto file and is placed in the highest layer of this folder as a pdf file
  - /_extensions contains all necessary extensions for rendering the Quarto file into a pdf file that matches the APA7 citation and format requirements

- how to handle this folder structure to produce the results: 
  - make sure that you've installed the latest Version von R and RStudio
  - if you're downloading the file from the repository on github.com, the first step is cloning the entire repository to your local device.
    otherwise, you're probably already in possession of the folder structure and can move on (skip the cloning)
      - note: a github account is required for cloning the repository 
  - set your working directory to this folder structure by selecting the .Rproj file 
  - Open all R Documents (they can be found in the subfolder 'simulation'). They are crucial for the simulated data later on) 
  - if not already done: please ensure that you have all necessary packages for R installed. 
    RStudio will remind you to press the button 'install' at the top of the document. You will automatically download all necessary packages for the code 
    after doing that
  - now you can Render the Quarto file. normally, this should work. But if you're working on a snapdragon processor, there will be some problems with Quarto. 
    In this case, switching to another device is highly recommended.
  - if you're being asked to installer further packages that are required for the Rendering and functioning of the Quarto file, pls follow the instructions in RStudio 
    (there should be an 'insttall' button at the top of the document again, press it)
  - if all worked out well: a pdf-file with the same name as the Quarto document should appear in your project folder - you're ready to go!
  
- license statement: this code wasn't licensed due to the didactic environment of the course



 
  
