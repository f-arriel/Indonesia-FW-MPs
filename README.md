# Indonesia-FW-MPs: Tool to Predict Microplastics Abundance in Indonesia’s Freshwater Ecosystems

This repository contains tools to predict microplastic (MPs) abundance in Indonesia’s freshwater ecosystems, combining spatial data processing and predictive modeling.

---

## Repository Contents

- **Google Colaboratory Notebook**  
  This notebook helps you prepare and export necessary predictor variables for MPs prediction in freshwater environments. The output is a `.csv` file with processed data.  
  *Features include:*  
  - Manual input of sampling locations or bulk upload via CSV  
  - Calculation of land use proportions (Commercial, Agriculture, Forest, Housing) within 1 km buffers  
  - Estimation of population density from raster data  
  - Generation of a ready-to-use CSV file for prediction

- **R Script**  
  An R script that utilizes the exported CSV file to predict MPs abundance across Indonesia’s freshwater ecosystems using a Generalized Additive Model (GAM). This script produces spatial prediction maps highlighting pollution hotspots.

- **Trained GAM Model File (`.rds`)**  
  The serialized GAM model used by the R script for prediction.

---

## How to Use

1. Open the Google Colaboratory notebook and input or upload sampling locations.  
2. Download the processed `.csv` file from the notebook.  
3. Run the R script locally or on your server with the `.rds` model file accessible.  
4. View or export predictive maps and analysis results.

---

## Citation

If you use this tool or our findings in your research, we kindly ask you to cite our conference presentation. The citation for the full paper will be added here upon publication.

**Full Paper:**  

Arriel Fadhilah*, Riyanto Haribowo, Yutaro Okumura, Mohammad Nouval Irfandhia Wahid, Shin-ichiro Kidou
"Revealing microplastic pollution hotspots in Indonesian freshwaters: a synthesis of methodological biases, anthropogenic drivers, and predictive hotspot mapping."  
Graduate School of Science, Nagoya City University, Japan; Faculty of Engineering, Universitas Brawijaya, Indonesia; Institut Teknologi Bandung, Indonesia; Research Center for Biological Diversity, Nagoya City University, Japan.  
*E-mail: fadhilah.arriel@gmail.com

---

Thank you for using Indonesia Freshwater Microplastics Predictor!
