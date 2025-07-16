# 🧪 Proteomics Analysis Pipeline

This repository provides a streamlined workflow for analyzing proteomics data using mzML files and [Sage](https://github.com/lazear/sage).

---

## 📦 Environment Setup

### 1. Create Conda Environment

Use the provided `environment.yml` file to create the analysis environment:

```bash
conda env create -f envs/environment.yml
conda activate mzml_env
```
### 2. Download Singularity (SIF) Image
You must obtain the .sif file for Sage execution.
It takes so long time.
```bash
singularity pull msconvert.sif docker://chambm/pwiz-skyline-i-agree-to-the-vendor-licenses
```

## 🔁 Workflow
The pipeline consists of the following steps:

### 1. Convert RAW to mzML
Run the script to convert individual .raw files to .mzML format:

```bash
bash convert_raws.sh
```
### 2. Merge mzML files per sample
Use the merge_mzmls.sh script to combine individual mzML files into one per sample:
```bash
bash merge_mzmls.sh
```
### 3. Run Sage
Execute Sage using the prepared JSON configuration:

```bash
sage global_250715.json
```
⚠️ Manual Step (for now)
Before running Sage, manually update the following section in global_250715.json:

```bash
"mzml_paths": [
  "/absolute/path/to/sample1/merged.mzML",
  "/absolute/path/to/sample2/merged.mzML"
]
```
🛠 This step will be automated in a future update.

