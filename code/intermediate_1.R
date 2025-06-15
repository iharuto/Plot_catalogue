# make_template_tree - Intermediate Circular Tree Network
# Simplified version without ggraph dependency

library(ggplot2)
library(dplyr)

make_template_tree_simple <- function(df) {
  # Create a simple circular arrangement for demonstration
  n_nodes <- nrow(df)
  angles <- seq(0, 2*pi, length.out = n_nodes + 1)[1:n_nodes]
  
  # Assign positions based on depth and angle
  positions <- df %>%
    mutate(
      angle = angles,
      radius = depth + 1,
      x = radius * cos(angle),
      y = radius * sin(angle),
      color = paste0("#", color_hex_triplet)
    )
  
  # Create edges for parent-child relationships
  edges <- df %>%
    filter(!is.na(parent_structure_id)) %>%
    left_join(positions %>% select(id, parent_x = x, parent_y = y), 
              by = c("parent_structure_id" = "id")) %>%
    left_join(positions %>% select(id, child_x = x, child_y = y), 
              by = "id")
  
  # Create the plot
  p <- ggplot() +
    geom_segment(aes(x = parent_x, y = parent_y, xend = child_x, yend = child_y),
                 data = edges, color = "gray70", alpha = 0.6) +
    geom_point(aes(x = x, y = y, color = I(color)), 
               data = positions, size = 3) +
    geom_text(aes(x = x * 1.2, y = y * 1.2, label = name), 
              data = positions, size = 3, hjust = 0.5, vjust = 0.5) +
    theme_void() +
    labs(title = "Hierarchical Tree Structure (Circular Layout)") +
    theme(plot.title = element_text(hjust = 0.5, size = 14)) +
    coord_fixed()
  
  return(p)
}

# Generate mock hierarchical data (brain atlas style)
set.seed(123)

mock_tree_data <- data.frame(
  id = 1:20,
  name = c("Root", "Cortex", "Subcortex", "Brainstem",
           "Frontal", "Parietal", "Temporal", "Occipital",
           "Thalamus", "Striatum", "Hypothalamus",
           "Midbrain", "Pons", "Medulla",
           "PFC", "M1", "S1", "V1", "A1", "HC"),
  parent_structure_id = c(NA, 1, 1, 1,
                          2, 2, 2, 2,
                          3, 3, 3,
                          4, 4, 4,
                          5, 5, 6, 8, 7, 7),
  color_hex_triplet = c("FF0000", "FF6666", "66FF66", "6666FF",
                        "FF9999", "FFCCCC", "FFFF99", "FFCC99",
                        "99FF99", "CCFFCC", "99FFCC",
                        "9999FF", "CCCCFF", "CC99FF",
                        "FFB3B3", "FFD9D9", "FFE6CC", "FFEECC", 
                        "FFFFCC", "F0F0CC"),
  depth = c(0, 1, 1, 1,
            2, 2, 2, 2,
            2, 2, 2,
            2, 2, 2,
            3, 3, 3, 3, 3, 3)
)

# Generate the plot
p <- make_template_tree_simple(mock_tree_data)

# Save the plot
ggsave("figure/intermediate_1.png", 
       plot = p, width = 10, height = 10, dpi = 300)

print("Intermediate_1: Circular tree plot created successfully!")
print(p)