# CLAUDE.md

## 🎯 Objective

This project aims to catalog R/ggplot2-based visualization functions stored in the `code_repository` folder. The goal is to generate a human-readable, categorized guide (e.g., `README.md`) that introduces each plotting function according to its complexity and visualization type.

Each entry in the catalog should include:
- 📊 A static image or schematic of the resulting plot (if possible)
- 📦 Required structure of the input dataframe
- 🧠 Estimated difficulty level (e.g., beginner / intermediate / advanced)
- 🧩 A minimal working example of the ggplot code (simplified but representative)
- 🗒️ File name and function name(s)

---

## 📁 Project Structure

All `.R` files are located in: code_repository

Each file may contain one or more ggplot-based visualization functions written in R. These functions assume tidyverse conventions and are targeted at exploratory or publication-quality plots.

---

## 🧠 Your Tasks (Claude Plan Mode)

You are expected to:

1. **Parse R Files**  
- Recursively scan all `.R` files inside `code_repository/`
   - Extract all user-defined ggplot2-based plotting functions
   - Infer complexity based on code length, number of layers, and ggplot customizations (themes, scales, facets, annotations, etc.)

2. **Categorize Each Function**  
   - By **difficulty**: `beginner`, `intermediate`, `advanced`
   - By **plot type**: e.g., `scatter`, `bar`, `line`, `violin`, `heatmap`, `multi-panel`, etc.

3. **For Each Plot Function, Create a README Section with:**
   - 🖼 **Preview** (if you can simulate a plot with mock data, do so; if not, skip or display schematic)
   - 🔧 **Expected dataframe structure**, e.g.:

     ```r
     data.frame(
       group = factor(),
       value = numeric()
     )
     ```

   - 📌 **Function signature** and file location
   - 🧪 **Minimal ggplot code excerpt** or generated simplified code
   - 📈 **Plot type**
   - 🧠 **Estimated difficulty level**
   - 🗂 **Tags** (e.g., `boxplot`, `facet`, `publication`, `custom theme`, etc.)

4. **Output**  
   - Format this information into a structured `README.md` catalog (in Markdown)
   - Use collapsible sections or headers (`##`, `###`) for clarity
   - one R file for one plot in code folder, file name should correspond to plot name
   - one png file for one plot in figure folder, file name should correspond to code file name


---

## 🔧 Environment Setup

**Important**: This project requires R environment with ggplot2 and related packages.

### R Environment via Miniconda
The project uses a conda environment called `r-env` with R and required packages:

```bash
# Activate the R environment
source /home/iharuto/miniconda3/etc/profile.d/conda.sh
conda activate r-env

# Execute R scripts
Rscript path/to/script.R

# Or run R interactively
R
```

### Required R Packages
The environment should include:
- `ggplot2` (core plotting)
- `dplyr` (data manipulation)
- `tidyverse` (data science ecosystem)
- `ggraph` (network plots)
- `tidygraph` (graph data structures)
- `viridis` (color scales)
- `patchwork` (plot composition)

### File Naming Convention
- **R scripts**: `{difficulty}_{id}.R` (e.g., `advanced_1.R`, `intermediate_1.R`)
- **PNG outputs**: `{difficulty}_{id}.png` (e.g., `advanced_1.png`, `intermediate_1.png`)
- **Difficulty levels**: `beginner`, `intermediate`, `advanced`
- **ID format**: Sequential numbers (1, 2, 3, etc.)

---

## ✅ Assumptions

- It is acceptable to use mock or randomly generated data to simulate plots.
- Use the conda `r-env` environment for R script execution.
- Execute code to generate static PNG previews when possible.
- If plot generation fails, fallback to code-only preview.

---

## 📌 Example Entry (Expected in README.md)

```markdown
### 📉 `plot_violin_by_group()` — Intermediate

**File**: `code_repository/violin_plots.R`  
**Plot Type**: Violin Plot  
**Tags**: `violin`, `grouped`, `facet`, `theme_minimal`

#### 📦 Expected Data Format

```r
data.frame(
  condition = factor(),
  expression = numeric()
)
```