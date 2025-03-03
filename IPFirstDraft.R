~# Load necessary libraries
library(ggplot2)
library(tidyr)

# Create a dataframe with all GO terms from the image (replace with exact values)
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
# Convert data to long format for ggplot
data_long <- pivot_longer(data, cols = c(Upregulated, Downregulated),
                          names_to = "Regulation", values_to = "Gene_Count")

# Remove rows where Gene_Count is NA (i.e., hide bars with a value of 0)
data_long <- data_long[!is.na(data_long$Gene_Count), ]

# Define custom colors for upregulation and downregulation
custom_colors <- c("Upregulated" = "#1f78b4", "Downregulated" = "#e31a1c")  # Blue & Red

# Plot the bar graph
ggplot(data_long, aes(x = reorder(Process, Gene_Count), y = Gene_Count, fill = Regulation)) +
  geom_bar(stat = "identity", position = "dodge") +  # Change to "stack" if you prefer stacked bars
  geom_text(aes(label = Gene_Count), vjust = -0.5, size = 3) +  # Add labels on bars
  labs(title = "Gene Regulation in *Belgica antarctica* Under Dehydration",
       subtitle = "Upregulated vs. Downregulated Biological Processes",
       x = "Biological Process (GO Term)",
       y = "Number of Genes",
       fill = "Regulation Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 8),  # Rotates x-axis labels
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12)) +
  scale_fill_manual(values = custom_colors) +
  coord_flip()  # Flips the bars for better readability

~
