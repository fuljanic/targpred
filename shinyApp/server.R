library(shinyjs)
library(logging)
library(stringr)

options(shiny.error = function() { 
  logging::logerror(sys.calls() %>% as.character %>% paste(collapse = ", ")) })

#load("/home/anjab/ShinyApps/scz/Schizophrenia_precalc_tables.Rdata")
load("/srv/shiny-server/Schizophrenia_precalc_tables.Rdata")
# sort locus coordinates so the drop-down menu looks nice:
study_locus_GRB.df <- study_locus_GRB.df[order(study_locus_GRB.df$locusPosition),]

# reformats to keep only start coordinate
study_snp_locus.df$SNPposition <- sapply(study_snp_locus.df$SNPposition, function(c){
                                             unlist(str_split(c, "[:-]"))[2]
                                         })

# gvizDir <- "/home/anjab/ShinyApps/scz/gvizPlots/"
# beanplotsDir <- "/home/anjab/ShinyApps/scz/expressionBeanplots/"
gvizDir <- "/srv/shiny-server/gvizPlots/"
beanplotsDir <- "/srv/shiny-server/expressionBeanplots/"

# returns a logical: is there a file with first gene in target_str in it's name?
are_there_figures <- function(target_str, dir) {
  target <- unlist(str_split(target_str, ","))[1]
  l <- length(list.files(dir, pattern=target))
  if(l>0) {
    return(T)
  }else{
    return(F)
  }
}


function(input, output) {
  
  printLogJs <- function(x, ...) {
    
    logjs(x)
    
    T
  }
  
  addHandler(printLogJs)
  
  # elements for "All SNPs" tab...
  output$snpUI <- renderUI({
    selectizeInput("GWASstudy", "Select GWAS study",
                   unique(study_snp_locus.df$GWASstudy),
                   selected = NULL, multiple = FALSE,
                   options = list(placeholder = "Select GWAS study"))
  })
  output$table <- DT::renderDataTable({
    
    if(input$radio=="inGRB") {
      DT::datatable(study_snp_locus.df[study_snp_locus.df$GWASstudy==input$GWASstudy &
                                         study_locus_GRB.df$inGRB==T, 
                                       c("SNP", "SNPposition", "locusRank", "locusPosition",
                                         "gwasGenes", "GWASstudy", "inGRB",
                                         "GRBposition", "GRBtargets", "GRBbystanders")])
    }else{
      DT::datatable(study_snp_locus.df[study_snp_locus.df$GWASstudy==input$GWASstudy, 
                                       c("SNP", "SNPposition", "locusRank", "locusPosition",
                                         "gwasGenes", "GWASstudy", "inGRB",
                                         "GRBposition", "GRBtargets", "GRBbystanders")], escape=FALSE)
    }
  }) 
  
  # elements for "All loci" tab...
  output$lociUI <- renderUI({
    selectizeInput("GWASstudy", "Select GWAS study",
                   unique(study_locus_GRB.df$GWASstudy),
                   selected = NULL, multiple = FALSE,
                   options = list(placeholder = "Select GWAS study"))
  })
  output$tableL <- DT::renderDataTable({
    
    if(input$radioL=="inGRB") {
      DT::datatable(study_locus_GRB.df[study_locus_GRB.df$GWASstudy==input$GWASstudy &
                                         study_locus_GRB.df$inGRB==T,
                                       c("locusRank", "locusPosition", "gwasGenes", "GWASstudy",
                                         "inGRB", "GRBposition", "GRBtargets", "GRBbystanders")])
    }else{
#      DT::datatable(study_locus_GRB.df[study_locus_GRB.df$GWASstudy==input$GWASstudy, 
#                                       c("locusRank", "locusPosition", "gwasGenes", "GWASstudy",
#                                         "inGRB", "GRBposition", "GRBtargets", "GRBbystanders")])
        dt <- DT::datatable(study_locus_GRB.df[study_locus_GRB.df$GWASstudy==input$GWASstudy, 
                                               c("locusRank", "locusPosition", "gwasGenes", "GWASstudy",
                                                 "inGRB", "GRBposition", "GRBtargets", "GRBbystanders")], escape=FALSE)
        dt[[1]]$data$inGRB <-  paste0("<a href='https://google.co.uk' target='_blank'>", dt[[1]]$data$inGRB, "</a>")
        return(dt)
    }
  }) 
  
  # elements for "Locus summary" tab...
  output$locusSummaryUI <- renderUI({
    selectizeInput("locusSummary", "Select GWAS locus",
                   unique(study_locus_GRB.df$locusPosition),
                   selected=sort(study_locus_GRB.df$locusPosition)[1], multiple = FALSE,
                   options = list(placeholder = "Select GWAS locus"))
  })
  output$studyTextForLocus <- renderText({
    paste("This GWAS locus was associated to", input$GWASstudy, sep=" ")
  })
  output$locusInGRB <- renderImage({
    if(study_locus_GRB.df$inGRB[study_locus_GRB.df$locusPosition==input$locusSummary]==T) {
      return(list(
        src="images/GRBin.png",
        contentType="image/png",
        alt="InGRB",
        width=250
      ))
    }else{
      return(list(
        src="images/GRBout.png",
        contentType="image/png",
        alt="OutGRB",
        width=250
      ))
    }
  }, deleteFile = FALSE)
  output$locusSummaryMainText <- renderText({
    if(study_locus_GRB.df$inGRB[study_locus_GRB.df$locusPosition==input$locusSummary]==F) {
      "This GWAS locus does not overlap a GRB, so no information on long range targets can be provided."
    }else{
      strng <- as.character(study_locus_GRB.df$GRBposition[study_locus_GRB.df$locusPosition==input$locusSummary])
      strng <- str_replace_all(strng, "[:-]", "_")
      
      if(are_there_figures(strng, gvizDir)) {
          "The left figure shows genomic neighbourhood of the GRB overlapping this locus.\n
The right plot shows significance of expression increase for the gene, in tissues in which enhancer is active, for every enhancer-promoter pair in the region."
      }else{
        "Locus overlaps a GRB,but no enhancers were found in the vicinity of the SNP."
      }
    }
  })
  output$locusSummaryMainPlot1 <- renderImage({
  
  if(study_locus_GRB.df$inGRB[study_locus_GRB.df$locusPosition==input$locusSummary]==F) {
    return(list(
      src="images/empty.png",
      contentType="image/png",
      width=750
    ))
  }else{
    strng <- as.character(study_locus_GRB.df$GRBposition[study_locus_GRB.df$locusPosition==input$locusSummary])
    strng <- str_replace_all(strng, "[:-]", "_")
    
    if(are_there_figures(strng, gvizDir)) {
      
      gvizPlotF <- list.files(gvizDir, pattern=strng) 
      return(list(
        #src=paste0("gvizPlots/", gvizPlotF),
        src=paste0("../gvizPlots/", gvizPlotF),
        contentType="image/png",
        alt="GenomicLocusPlot",
        width=750
      ))
    }else{
      return(list(
        src="images/empty.png",
        contentType="image/png",
        width=750
      ))
    }
  }
  }, deleteFile=FALSE)
  output$locusSummaryMainPlot2 <- renderImage({
  
  if(study_locus_GRB.df$inGRB[study_locus_GRB.df$locusPosition==input$locusSummary]==F) {
    return(list(
      src="images/empty.png",
      contentType="image/png",
      width=750
    ))
  }else{
    strng <- as.character(study_locus_GRB.df$GRBposition[study_locus_GRB.df$locusPosition==input$locusSummary])
    strng <- str_replace_all(strng, "[:-]", "_")
    
    if(are_there_figures(strng, beanplotsDir)) {
      
      expBeanplotF <- list.files(beanplotsDir, pattern=strng) 
      return(list(
        #src=paste0("expressionBeanplots/", expBeanplotF),
        src=paste0("../expressionBeanplots/", expBeanplotF),
        contentType="image/png",
        alt="EnhancerPromoterCorrPlot",
        width=750
      ))
    }else{
      return(list(
        src="images/empty.png",
        contentType="image/png",
        width=750
      ))
    }
  }
}, deleteFile=FALSE)
  
}
