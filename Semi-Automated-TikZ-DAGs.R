
```{r setup, include=FALSE}

# Semi-automated TikZ directed acyclic graphs in R.
#
# This script generates TikZ code for rendering directed acyclic graphs.
# That TikZ code is copied to the system's clipboard, with the intent that the
# user paste it into a LaTeX document for typesetting.
#
# Accompanying article:
# Stenborg, T 2024, "Semi-automated TikZ Directed Acyclic Graphs in R",
# TUGboat, vol. 45, no. 1, pp. 115-116.


# It's assumed causalDisco v0.9.3 or above, and its supporting packages, are
# installed. As of 2024-Sep, the following calls suffice.
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(c("graph", "RBGL", "Rgraphviz"))
github_repo <- "annennenne/causalDisco"
devtools::install_github(github_repo)

# Initialise a DAG matrix.
dag_matrix = matrix(
  c(0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
    1, 1, 0, 0, 0, 0, 0,
    1, 0, 1, 1, 0, 0, 0,
    0, 1, 1, 0, 1, 0, 0,
    0, 0, 0, 1, 0, 1, 0),
  nrow = 7,
  ncol = 7,
  byrow = TRUE
)

# Specify matching matrix row and column names.
rownames(dag_matrix) <- c(
  "a_nd1", "a_nd2", "a_nd3", "b_nd4", "b_nd5", "b_nd6", "c_nd7")
colnames(dag_matrix) = rownames(dag_matrix)

# Create a temporal adjacency matrix.
model <- causalDisco::tamat(
  dag_matrix, c("a", "b", "c"))

# Render TikZ and copy to clipboard.
causalDisco::maketikz(model, xjit = 0,
  markperiods = FALSE, addAxis = FALSE,
  varLabels = list(
    a_nd1 = "Depth",
    a_nd2 = "\\footnotesize Structural\\\\
             \\footnotesize Complexity",
    a_nd3 = "\\footnotesize Human\\\\
             \\footnotesize Gravity",
    b_nd4 = "MPA",
    b_nd5 = "\\footnotesize Fishing\\\\
             \\footnotesize Pressure",
    b_nd6 = "\\footnotesize Reef Fish\\\\
             \\footnotesize Biomass",
    c_nd7 = "\\footnotesize Coral\\\\
             \\footnotesize Cover")
  )
```
