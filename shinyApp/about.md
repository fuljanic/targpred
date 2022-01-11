---
title: "About"
author: "Anja Baresic"
date: '`r format(Sys.Date(), "%B %d, %Y")`'
output: html_document
---

## Schizophrenia-associated GWAS SNPs in the genomic regulatory blocks context

This Web site presents variants and loci associated in GWAS studies listed below, in the context of genomic regulatory blocks (GRBs). The aim here is to provide, in case where a disease-assocated locus is found overlapping a GRB, a comprehensive view of the range of conserved synteny around the locus. In the case where causative non-coding SNP within that locus is suspected to not have a local effect, i.e. the SNP is disrupting a regulatory element affecting a gene over a large distance, GRB model provides 

- the range of long-range regulation (boundaries within which a shared regulatory landscape is expected, correlating roughly to a topologically-associated domain in the region), and more importantly
- a prediction of most likely gene(s) to be under long range regulation within that GRB
<br/>


#### Data source
Currently this app covers variants detected as genome-wide significant in Ripke et al. 2014 (add a link). LD blocks=loci

To be expanded to all variants found in GWAS catalog (time stamp, add link).
<br/>

#### Genomic regulatory blocks 
human:mouse at the moment...
<br/>

## How to browse the data
There are several levels on which one can start looking into variants involved in long-range regulation. "All SNPs" provides all SNPs in a chosen study in a tabular form summarising SNP and LD block information from the original paper, and in case where SNP is in a locus that overlaps a GRB, all genes within that GRB are listed and classified either as targets or bystanders. 

"All loci", like all SNPs provide information on all loci in a chosen GWAS study in a tabular form. The user is encouraged to focus on subset of SNPs/loci that fall within GRBs only, as there is no additional information we can provide for the ones outside of GRBs. Clicking on the individual entry under "locusPosition" will lead to per-locus summary page, see below.

"Locus summary" page provides additional information for a locus overlapping a GRB, like the list of the GRB target and bystander genes.

IN the case where the locus is found to contain at least one permissive enhancer from FANTOM5, this page will contain two additional Figures linking these enhancers to all GWAS- and GRB-associated promoters in the region. First, a schema of the genomic region encompassing the GWAS locus and the GRB is presented
<br/>

Here is an example of ...
