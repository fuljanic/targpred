library(DT)
library(markdown)
library(shinyjs)
library(stringr)

navbarPage("Schizophrenia SNPs in GRBs", 

           tabPanel("All SNPs",
                    fluidRow(column(4,
                                    uiOutput("snpUI")),
                             column(4,
                                    radioButtons("radio", label=h4("SNP subsetting"),
                                                 choices=list("All SNPs"="all", 
                                                     "SNPs in GRB loci"="inGRB")))),
                    mainPanel(br(),
                              DT::dataTableOutput("table"))),
           tabPanel("All loci",
                    fluidRow(column(4,
                                    uiOutput("lociUI")),
                             column(4,
                                    radioButtons("radioL", label=h4("Locus subsetting"),
                                                 choices=list("All loci"="all", 
                                                     "Loci in GRBs"="inGRB")))),
                    mainPanel(br(),
                              DT::dataTableOutput("tableL"))),
           tabPanel("Locus summary",
                    fluidRow(column(4,
                                    uiOutput("locusSummaryUI")),
                             column(8,
                                    verbatimTextOutput("studyTextForLocus"))),
                    br(),
                    fluidRow(column(4,
                                    imageOutput("locusInGRB")),
                             column(8,
                                    verbatimTextOutput("locusSummaryMainText"))),
                    fluidRow(column(6,
                                    imageOutput("locusSummaryMainPlot1")),
                             column(6,
                                    imageOutput("locusSummaryMainPlot2"))),
                    br()
                    ),
           # add tabPanel for SNP summary
           # SNP summary does: study, GWAS genes, locus, any other SNPs in LD, GTEx eQTLs (can we download these?)
           # if in GRB, list GRB genes and two plots or a message that no enhancers were found
           # make locus linkable to locus summary
           
           # add another tab here? gene summary? both genes?
           tabPanel("About",
                    includeMarkdown("about.md"))
)




