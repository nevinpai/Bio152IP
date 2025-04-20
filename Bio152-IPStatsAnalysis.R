# Data setup
data <- data.frame(
  Process = c("Ubiquitin-dependent protein catabolic process", "R7 cell fate commitment",
              "Response to heat", "Actin filament organization", "Protein phosphorylation",
              "Small GTPase mediated signal transduction", "Regulation of protein catabolic process",
              "Proteolysis", "Metabolic process", "Oxidation-reduction process", "Chitin metabolic process",
              "Proton transport", "ATP synthesis coupled proton transport", "Carbohydrate metabolic process",
              "ATP biosynthetic process", "Lipid metabolic process", "Transport", "Glycolysis",
              "Transmembrane transport", "Tricarboxylic acid cycle", "Mitochondrial electron transport",
              "Amino acid transmembrane transport", "Cation transport", "Cellular carbohydrate metabolic process",
              "Carbohydrate transport", "Monovalent inorganic cation transport",
              "ATP hydrolysis coupled proton transport", "Chitin catabolic process",
              "Viral transcription", "Amino acid transport", "Peptidoglycan catabolic process"),
  Upregulated = c(29, 10, 21, 28, 86, 26, 6, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
  Downregulated = c(NA, NA, NA, NA, NA, NA, NA, 152, 193, 160, 44, 19, 14, 48, 17, 41, 133, 15, 82, 15, 6, 11, 15, 5, 18, 4, 11, 9, 6, 7, 6)
)

# Replace NAs with 0 for the test
upregulated_counts <- sum(!is.na(data$Upregulated))
downregulated_counts <- sum(!is.na(data$Downregulated))

# Observed counts: sum of upregulated and downregulated
observed_counts <- c(upregulated_counts, downregulated_counts)

# Expected counts based on the hypothesis that 70% are downregulated and 30% upregulated
total_counts <- sum(observed_counts)
expected_counts <- c(total_counts * 0.4, total_counts * 0.6)

# Perform the chi-square goodness-of-fit test
chi_square_test <- chisq.test(observed_counts, p = expected_counts / total_counts)

# Print the results
print(chi_square_test)
