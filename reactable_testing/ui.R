
library(reactable)
library(shiny)

grb_dt <- readRDS("loci_in_grb_df.rds")
data <- grb_dt
fluidPage(
  titlePanel("GRB testing"),
  selectInput("filter_type", "GWAS trait:",c("All",unique(as.character(data$MAPPED_TRAIT)))),
  reactableOutput("table")
)
