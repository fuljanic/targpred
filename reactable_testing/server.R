library(reactable)
library(shiny)
grb_dt <- readRDS("loci_in_grb_df.rds")
data <- grb_dt
function(input, output) {

  output$table <-  renderReactable({
    reactable(
      data,
      filterable = TRUE,
      searchable = TRUE,
      selection = "multiple",
      minRows = 10)
})
  observe({
  filtered <- if (length(input$filter_type) > 0) {
    data[data$MAPPED_TRAIT %in% input$filter_type, ]
  } else {
    data
  }
  updateReactable("table", data = filtered)
})
  
}