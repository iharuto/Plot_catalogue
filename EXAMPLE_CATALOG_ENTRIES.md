# 📊 Plot Catalogue - Example Entries

*This document shows example catalog entries for three representative functions from each R file.*

---

## 🔬 From `figure_function_Brain_Blast.R`

### 📉 `SankeyArrow()` — Advanced

**File**: `code_repository/figure_function_Brain_Blast.R:3`  
**Plot Type**: Flow Diagram / Sankey  
**Tags**: `flow`, `sankey`, `custom_geometry`, `segments`, `publication`

#### 📦 Expected Data Format

```r
# Parameters:
values = numeric()    # Flow values (input followed by outputs)
label = character()   # Labels for each flow segment
gap = 0.05           # Gap between segments
size = 4             # Text size
force = FALSE        # Force plot even if inputs != outputs
trans_log = FALSE    # Apply log transformation
```

#### 🧠 Difficulty Level: **Advanced**
- Complex geometric calculations for flow positioning
- Multiple `geom_segment()` layers with custom positioning
- Dynamic layout based on proportional values
- Custom arrow and flow visualization logic

#### 🧪 Minimal Code Example

```r
# Core ggplot structure
ggplot() +
  geom_segment(aes(x = -0.4, y = 0, xend = -0.32, yend = 0.5)) +
  geom_segment(aes(x = -0.4, y = 1, xend = -0.32, yend = 0.5)) +
  geom_segment(aes(x = -0.2, y = 1, xend = -0.2, yend = 0), linetype = "dashed") +
  # Dynamic segments added in loop...
  coord_fixed(ratio = 1) + theme_void()
```

---

## 🧠 From `figure_function_EEG_analysis.R`

### 📊 `plot_PCA_raw_EEG_mouse()` — Advanced

**File**: `code_repository/figure_function_EEG_analysis.R:38`  
**Plot Type**: Multi-layer Scatter Plot with EEG Traces  
**Tags**: `PCA`, `EEG`, `time_series`, `multi_layer`, `neuroscience`, `scatter`

#### 📦 Expected Data Format

```r
# Required data structures:
e = list()           # Named list of EEG data matrices (mouse_id -> matrix)
d = data.frame(
  data.ID = character(),     # Mouse identifier
  latent1 = numeric(),       # First PCA component
  latent2 = numeric(),       # Second PCA component
  epoch = numeric(),         # Time epoch
  cluster.4 = factor()       # Phase/cluster assignment
)

# Parameters:
mouse = "M24349"      # Mouse ID to plot
distance = 1          # Scaling factor
lowerPeriod = 8       # Wavelet lower period
upperPeriod = 16      # Wavelet upper period  
lowerHz = 10          # Lower frequency bound
upperHz = 15          # Upper frequency bound
```

#### 🧠 Difficulty Level: **Advanced**
- Complex data transformations (wavelet analysis)
- Multiple coordinate systems and data mapping
- Advanced geometric calculations for positioning
- Multi-layer plot with 6+ geom types
- Custom color scaling with dynamic range calculation

#### 🧪 Minimal Code Example

```r
# Core visualization structure
ggplot(mapping = aes(latent1, latent2)) +
  geom_point(aes(fill = cluster.4), d, shape = 21, size = 1, stroke = NA) +
  geom_segment(aes(xend = 2.5 * sqrt(2) / distance * latent1, 
                   yend = 2.5 * sqrt(2) / distance * latent2), target_df) +
  geom_point(data = target_df, color = "black", size = 1) +
  geom_text(aes(4.75 * sqrt(2) / distance * latent1,
                4.75 * sqrt(2) / distance * latent2, label = epoch), target_df) +
  geom_path(aes(x, y, group = Epochs, color = Sigma), target_EEG_df, linewidth = 0.1) +
  scale_color_gradient2(high = "red", low = "blue", mid = "gray50") +
  theme_void()
```

---

## 🌳 From `figure_function_IUNCTIO.R`

### 🔗 `make_template_tree()` — Intermediate

**File**: `code_repository/figure_function_IUNCTIO.R:1`  
**Plot Type**: Circular Tree Network  
**Tags**: `network`, `tree`, `circular`, `ggraph`, `hierarchical`, `brain_atlas`

#### 📦 Expected Data Format

```r
# Required data structure:
df = data.frame(
  id = numeric(),                    # Unique node identifier
  parent_structure_id = numeric(),   # Parent node ID
  color_hex_triplet = character(),   # Hex color (without #)
  # ... other node attributes
)

# Parameters:
root.node = 4006    # Root node ID (default)
```

#### 🧠 Difficulty Level: **Intermediate**
- Uses specialized `ggraph` package for network layouts
- Graph data structure creation with `tbl_graph()`
- Circular tree layout with custom edge styling
- Returns processed ggplot_build object for further manipulation

#### 🧪 Minimal Code Example

```r
# Core network visualization
library(ggraph)
library(tidygraph)

# Create graph structure
edges <- df %>% select(from = parent_structure_id, to = id)
g <- tbl_graph(nodes = df, edges = edges, directed = TRUE, node_key = "id")

# Generate circular tree plot
ggraph(g, layout = "tree", circular = TRUE) +
  geom_edge_diagonal2(color = "gray90", width = 0.5) +
  theme_void()
```

---

## 📋 Summary

These three examples demonstrate the range of visualization complexity:

- **SankeyArrow**: Custom geometric flow diagrams with proportional layouts
- **plot_PCA_raw_EEG_mouse**: Complex scientific visualization combining multiple data types
- **make_template_tree**: Network visualization using specialized graph layout algorithms

Each entry provides enough information for users to understand the function's purpose, required data format, and implementation approach.