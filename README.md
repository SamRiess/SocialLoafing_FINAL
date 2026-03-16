# SocialLoafing_SamuelRiess
This is the final repository for the course "Empirisch-psychologisches Praktikum" of 2025/2026. 

Author of the individual report: Samuel Riess

#README-File for simplification of the reproducibility of the report's results. 

- title:  Formal Modeling of the Social Impact Theory: Applications to Social Loafing and Effort Matching phenomena
- authors: Samuel Riess (maybe add the other group members later on)
- Date of disposal: 16.03.2026
- contact information: 
  Felix Schönbrodt (instructor of the didactic course in which this project took place): felix.schönbrodt@psy.lmu.de
  Samuel Riess (author): Samuel.riess@campus.lmu.de
  
How to handle this folder structure to produce the results: 
  - make sure that you've installed the latest Version of R and RStudio.
  - if you're downloading the file from the repository on github.com, the first step is cloning the entire repository to your local device.
      - note: a github account is required for cloning the repository 
  - set your working directory to this folder structure by selecting the .Rproj file
  - Open all R Documents (they can be found in the subfolder 'simulation'). They are crucial for the simulated data later on) 
  - dependencies: please ensure that you have all necessary packages for R installed. 
    RStudio will usually prompt you with an "install" button at the top of the editor. You will automatically download all necessary packages for the code 
    after doing this
  - Rendering: Open the .qmd file and click the Render button. 
      - Note for ARM-based devices (e.g., Snapdragon): You might encounter compatibility issues with certain Quarto/LaTex engines. 
        Using a x86-based system is recommended if rendering fails.
      - if prompted to install further packages or extensions (like apaquarto), please follow the instruction in Rstudio
  - if all worked out well, a pdf-file will be generated and open automatically
  
Short guide throughout the folder structure: 
- _extensions: these are necessary to render the Quarto document into a pdf that fits the APA7 citation and format requirements
- Base_literature: contains the references.bib file. 
- simulation: in this folder lies the code for our simulation and formalized theory and model. These scripts are automatically called by the Quarto document, no manual execution is required. 
- subfolder "doc": contains VAST Displays and Graphics used in the report
You can ignore the rest of the files in the project folder, for they're necessary to run the other documents, but do not include extra information that is crucial for the report itself. 

The final report can be seen in the pdf-file, that is rendered after running the whole Quarto document. It has the same name as the Quarto file, but with the appendix ".pdf". It should open
autonomously after running the Quarto file. 

- instruction for the citation of this report: 
  This report was part of a didactic course at LMU Munich. All information concerning citations can be found in the CITATION.cff file
- license statement: the CITATION.cff file contains this information too. Pls check it first and contact the author if there are some issues


  
short description of the project: 
This report tries to formalize an existing psychological theory (precisely: the social impact theory) and its emerging phenomenon, the social loafing effect. We use the Visual Argument Structure Tool (VAST) throughout the process.
The main goal is to prove if the formalized theory can account for the phenomenon to secure the link between verbal theory and simulated data, based on the formalization. 
The results were beneficial: with our constructed model, we were able to replicate main findings of this subject. 
Therefore, we draw the conclusion that the social impact theory is capable of explaining and producing social loafing as a robust phenomenon. 

abstract:
In light of the replication crisis, precise links between theories and their emerging phenomena are becoming increasingly relevant for the psychological research community. With this research, we aim to test the connection between the 
existing Social Impact Theory and one of its emergent phenomena, the Social Loafing effect. Further, Effort Matching as an extending mechanism was observed to generate a broader perspective. Throughout our formalization, we used the Visual Argument Structure Tool 
to reshape the verbal tenets into a graphic illustration which contains all relevant identifiable constructs of the theory. The resulting mathematical model contained several extensions and restrictions, driven by the goal to design a self-consistent framework and
by the need to address inconsistencies in previous research. Whilst simulating data for a fictional experimental design, we provided support for the model and therefore the Social Impact Theory itself. This leads to a logical conclusion that Social Loafing and 
Effort Matching emerge directly from its theoretical foundation, proving that this specific connection between theory and phenomenon requires no substantial modification.


  
