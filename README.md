# R/ggplot2 Plot Catalogue

## advanced_1.png - SankeyArrow Flow Diagram

![](figure/advanced_1.png)

**Code:** [`code/advanced_1.R`](code/advanced_1.R)
```r
SankeyArrow(values = c(1000, 300, 250, 200, 150, 100), 
            label = c("Input", "Process A", "Process B", "Process C", "Process D", "Output"),
            gap = 0.05, size = 4, force = TRUE)
```

**Data Structure:**
```r
values = c(numeric)  # Flow values (input + outputs)  
label = c(character) # Process labels
```

---

## advanced_2.png - EEG PCA Visualization

![](figure/advanced_2.png)

**Code:** [`code/advanced_2.R`](code/advanced_2.R)  
```r
plot_PCA_raw_EEG_mouse_simple(data, mouse_id = "M001", distance = 1)
```

**Data Structure:**
```r
data.frame(
  data.ID = character(),   # Subject identifier
  latent1 = numeric(),     # First PCA component
  latent2 = numeric(),     # Second PCA component  
  epoch = numeric(),       # Time epoch number
  cluster.4 = factor()     # Phase assignment
)
```

---

## intermediate_1.png - Circular Tree Network

![](figure/intermediate_1.png)

**Code:** [`code/intermediate_1.R`](code/intermediate_1.R)
```r
make_template_tree_simple(data)
```

**Data Structure:**
```r
data.frame(
  id = numeric(),                    # Node identifier
  name = character(),                # Node label
  parent_structure_id = numeric(),   # Parent node ID (NA for root)
  color_hex_triplet = character(),   # Hex color without '#'
  depth = numeric()                  # Hierarchical level
)
```