# plot_PCA_raw_EEG_mouse - Advanced EEG Visualization
# Recreated from figure_function_EEG_analysis.R with mock data

library(ggplot2)
library(dplyr)

# Simplified version without wavelet transformation dependency
plot_PCA_raw_EEG_mouse_simple <- function(d, mouse_id = "M001", distance = 1) {
  # Filter data for specific mouse
  d_mouse <- subset(d, data.ID == mouse_id)
  distance <- sqrt(distance)
  
  # Create circular sampling points
  angles <- seq(0, 2*pi, length.out = 13)[-13]  # 12 points
  points_on_circle <- data.frame(
    x = cos(angles) * distance,
    y = sin(angles) * distance
  )
  
  # Find nearest points in latent space
  find_nearest <- function(point, df) {
    distances <- sqrt((df$latent1 - point$x)^2 + (df$latent2 - point$y)^2)
    df[which.min(distances), ]
  }
  
  # Get representative epochs
  nearest_points <- lapply(1:nrow(points_on_circle), function(i) {
    find_nearest(points_on_circle[i, ], d_mouse[, c("latent1", "latent2")])
  })
  nearest_indices <- sapply(nearest_points, function(x) which(d_mouse$latent1 == x$latent1 & d_mouse$latent2 == x$latent2)[1])
  target_df <- d_mouse[nearest_indices, ]
  
  # Create mock EEG traces for visualization
  n_timepoints <- 100
  eeg_traces <- do.call(rbind, lapply(1:nrow(target_df), function(i) {
    # Simulate EEG trace with some frequency content
    time_vec <- seq(0, 10, length.out = n_timepoints)
    voltage <- sin(2 * pi * (8 + i) * time_vec) * exp(-time_vec/5) + 
               rnorm(n_timepoints, 0, 0.1)
    sigma_amp <- abs(voltage) + runif(n_timepoints, 0.5, 1.5)
    
    data.frame(
      Voltage = voltage,
      Sigma = sigma_amp,
      Time = time_vec,
      Epochs = target_df$epoch[i],
      Phase = target_df$cluster.4[i],
      latent1_orig = target_df$latent1[i],
      latent2_orig = target_df$latent2[i]
    )
  }))
  
  # Transform coordinates for visualization
  eeg_traces$x <- eeg_traces$latent1_orig * 3.5 * sqrt(2) / distance + eeg_traces$Time * 0.2 - 1
  eeg_traces$y <- eeg_traces$latent2_orig * 3.5 * sqrt(2) / distance + eeg_traces$Voltage * 0.2
  
  # Apply log transformation to sigma
  eeg_traces$log_Sigma <- log10(eeg_traces$Sigma)
  mid <- median(eeg_traces$log_Sigma)
  color_range <- range(eeg_traces$log_Sigma)
  
  # Create the plot
  ggplot(mapping = aes(latent1, latent2)) +
    geom_point(aes(fill = cluster.4), d_mouse, shape = 21, size = 1, stroke = NA) +
    geom_segment(aes(xend = 2.5 * sqrt(2) / distance * latent1, 
                     yend = 2.5 * sqrt(2) / distance * latent2), target_df) +
    geom_point(data = target_df, color = "black", size = 1) +
    geom_text(aes(4.75 * sqrt(2) / distance * latent1,
                  4.75 * sqrt(2) / distance * latent2, label = epoch), target_df) +
    geom_path(aes(x, y, group = Epochs, color = log_Sigma), eeg_traces, linewidth = 0.1) +
    scale_color_gradient2(high = "red", low = "blue", mid = "gray50", 
                          name = "log(Sigma amplitude)",
                          midpoint = mid, limits = color_range, na.value = "gray50") +
    scale_fill_viridis_d(name = "Phase") +
    theme_void() + 
    theme(plot.margin = unit(c(1, 1, 1, 1), "lines")) +
    guides(fill = guide_legend(override.aes = list(size = 3))) +
    labs(title = paste("EEG Analysis for Mouse", mouse_id))
}

# Generate mock data
set.seed(42)
n_epochs <- 201  # Make it divisible by 3

mock_data <- data.frame(
  data.ID = rep(c("M001", "M002", "M003"), each = n_epochs/3),
  latent1 = rnorm(n_epochs, 0, 1),
  latent2 = rnorm(n_epochs, 0, 1),
  epoch = rep(1:(n_epochs/3), 3),
  cluster.4 = factor(sample(1:4, n_epochs, replace = TRUE))
)

# Generate the plot
p <- plot_PCA_raw_EEG_mouse_simple(mock_data, mouse_id = "M001")

# Save the plot
ggsave("figure/advanced_2.png", 
       plot = p, width = 10, height = 8, dpi = 300)

print("Advanced_2: EEG PCA plot created successfully!")
print(p)