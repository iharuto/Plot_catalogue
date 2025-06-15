# SankeyArrow - Advanced Flow Diagram Visualization
# Recreated from figure_function_Brain_Blast.R with mock data

library(ggplot2)

SankeyArrow <- function(values, label, gap = 0.05, size = 4, force = F, trans_log = F) {
  labels <- paste0(label, " \n(", values, ")")
  labels <- c(labels[1], labels[length(labels)], labels[(length(labels) - 1) : 2])
  
  if (trans_log) {
    values <- log(values)
  }
  
  inputs <- values[1]
  outputs <- values[-1]
  
  if (inputs != sum(outputs) & !force) {
    stop("outputs != inputs")
  } else {
    inputs <- sum(outputs)
    values[1] <- inputs
  }
  
  text_y <- 0.5
  text_x <- -0.32 - gap
  
  op <- outputs / inputs
  op_bottom <- 1 - cumsum(outputs) / inputs
  op_top <- op_bottom + outputs / inputs
  
  x_inits <- c(0, cumsum(1.5 * op[-length(op)]))
  
  g <- ggplot() +
    geom_segment(aes(x = -0.4, y = 0, xend = -0.32, yend = 0.5)) +
    geom_segment(aes(x = -0.4, y = 1, xend = -0.32, yend = 0.5)) +
    geom_segment(aes(x = -0.2, y = 1, xend = -0.2, yend = 0), linetype = "dashed")
  
  for (i in length(op) : 1) {
    if (i == length(op)) {
      line1 <- data.frame(x = -0.4, y = 0, xend = x_inits[i], yend = 0)
      line2 <- data.frame(x = x_inits[i - 1], y = op_top[i], xend = x_inits[i], yend = op_top[i])
      line3 <- data.frame(x = x_inits[i], y = 0, xend = x_inits[i] + 0.08 * op[i], yend = op[i] / 2)
      line4 <- data.frame(x = x_inits[i], y = op_top[i], xend = x_inits[i] + 0.08 * op[i], yend = op[i] / 2)
      
      g <- g + 
        geom_segment(aes(x = x, y = y, xend = xend, yend = yend), line1) + 
        geom_segment(aes(x = x, y = y, xend = xend, yend = yend), line2) + 
        geom_segment(aes(x = x, y = y, xend = xend, yend = yend), line3) + 
        geom_segment(aes(x = x, y = y, xend = xend, yend = yend), line4)
      
      y_top <- op_top[i]
      text_y <- c(text_y, op[i] / 2)
      text_x <- c(text_x, x_inits[i] + 0.08 * op[i] + gap)
    } else {
      small_circle <- data.frame(
        x = x_inits[i] - 0.08 * op[i], y = op[i] / 2,
        xend = x_inits[i] + 0.08 * op[i], yend = op[i] / 2,
        curvature = -0.5
      )
      large_circle <- data.frame(
        x = x_inits[i] - 0.08 * op[i], y = op[i] / 2,
        xend = x_inits[i] + 0.08 * op[i], yend = op[i] / 2,
        curvature = 0.5
      )
      
      g <- g +
        geom_curve(aes(x = x, y = y, xend = xend, yend = yend), small_circle, curvature = -0.5) +
        geom_curve(aes(x = x, y = y, xend = xend, yend = yend), large_circle, curvature = 0.5)
      
      y_top <- y_top + op[i] / 2
      text_y <- c(text_y, y_top)
      text_x <- c(text_x, x_inits[i] + 0.08 * op[i] + gap)
    }
  }
  
  label_df <- data.frame(x = text_x, y = text_y, label = labels)
  
  g <- g + 
    geom_text(aes(x, y, label = label), label_df[1, ], hjust = 1, size = size) +
    geom_text(aes(x, y, label = label), label_df[2, ], hjust = 0, size = size) +
    geom_text(aes(x, y, label = label), label_df[-1 : -2, ], vjust = 0, hjust = 0, size = size)
  
  g <- g + coord_fixed(ratio = 1) + theme_void() +
    scale_x_continuous(limits = c(-1, label_df$x[2] + 0.6)) +
    scale_y_continuous(limits = c(-0.1, 1.1))
  
  return(g)
}

# Mock data for demonstration
mock_values <- c(1000, 300, 250, 200, 150, 100)
mock_labels <- c("Input", "Process A", "Process B", "Process C", "Process D", "Output")

# Generate the plot
p <- SankeyArrow(values = mock_values, label = mock_labels, force = TRUE)

# Save the plot
ggsave("figure/advanced_1.png", 
       plot = p, width = 10, height = 6, dpi = 300)

print("Advanced_1: SankeyArrow plot created successfully!")
print(p)