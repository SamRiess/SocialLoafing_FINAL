# SocialLoafing_SamuelRiess
This is the final repository for the course "Empirisch-psychologisches Praktikum" of 2025/2026. 

Author of the individual report: Samuel Riess

#README-File for simplification of the reproducibility of the report's results. 

- title:  (insert title later on)
- authors: Samuel Riess (maybe add the other group members later on)
- Date of disposal: (add this later on)
- contact information: 
  Felix Schönbrodt (instructor of the didactic course in which this project took place): felix.schönbrodt@psy.lmu.de
  Samuel Riess (author): Samuel.riess@campus.lmu.de
  
How to handle this folder structure to produce the results: 
  - make sure that you've installed the latest Version von R and RStudio
  - if you're downloading the file from the repository on github.com, the first step is cloning the entire repository to your local device.
    otherwise, you're probably already in possession of the folder structure and can move on (skip the cloning)
      - note: a github account is required for cloning the repository 
  - set your working directory to this folder structure by selecting the .Rproj file (it makes the work easier later on)
  - Open all R Documents (they can be found in the subfolder 'simulation'). They are crucial for the simulated data later on) 
  - if not already done: please ensure that you have all necessary packages for R installed. 
    RStudio will remind you to press the button 'install' at the top of the document. You will automatically download all necessary packages for the code 
    after doing this
  - now you can Render the Quarto file. Normally, this should work. But if you're working on a snapdragon laptop, there will be some problems with Quarto. 
    In this case, switching to another device is highly recommended.
  - if you're being asked to install further packages that are required for the Rendering and functioning of the Quarto file, please follow the instructions in RStudio 
    (there should be an 'insttall' button at the top of the document again, click it)
  - if all worked out well: a pdf-file with the same name as the Quarto document should appear in your project folder - you're ready to go! 
  (since this report was handed in before, there is already the final report and its .pdf file. But it the version changes later on, you can update it with this mechanism)

Short guide throughout the folder structure: 
- subfolder _extensions: these are necessary to render the Quarto document into a pdf that fits the APA7 citation and format requirements
- subfolder Base_literature: here you will find all the literature this report is based on. 
  furthermore, the "references.bib" file contains all the literature, so it can be cited in the final report. It should be linked to the other documents
- subfolder "simulation": in this folder lays the code for our simulation and formalized theory and model. These documents are sourced in the Quarto document as well, so you don't have to run them separately
- subfolder "doc": the VAST Displays and Graphics that are used in the process of writing the report can be found here. The plots of the simulation are found in the final report for they are directly rendered 
  with the Quarto document
You can ignore the rest of the files in the project folder,  for they're necessary to run the other documents, but do not include extra information that is crucial for the report itself. 

The final report can be seen in the pdf-file, that is rendered after running the whole Quarto document. It has the same name as the Quarto file, but with the appendix ".pdf". It should open
autonomously after running the Quarto file. 

- instruction for the citation of this report: 
  This report was part of a didactic course at LMU Munich). All information concerning citations can be found in the CITATION.cff file
- license statement: the CITATION.cff file contains this information too. Pls check it first and contact the author if there are some issues


  
short description of the project: 
This report tries to formalize an existing psychological theory (precisely: the social impact theory) and its emerging phenomenon, the social loafing effect. We use the Visual Argument Structure Tool (VAST) throughout the process.
The main goal is to prove if the formalized theory can account for the phenomenon to secure the link between verbal theory and simulated data, based on the formalization. 
The results were beneficial: with our constructed model, we were able to replicate main findings of this subject. 
Therefore, we draw the conclusion that the social impact theory is capable of explaining and producing social loafing as a robust phenomenon. 





  
