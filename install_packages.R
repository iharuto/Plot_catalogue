# Install required packages if not available
packages <- c("ggraph", "tidygraph", "viridis")

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, repos = "https://cran.r-project.org")
    library(pkg, character.only = TRUE)
  }
}

cat("Package installation check complete!\n")