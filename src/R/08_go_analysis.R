if(!exists("deg_filt_list")) {
  deg_filt_list <- readRDS(paste(dir_list$rds, "deg_filt_list.rds", sep = "/"))
}

if(!exists("training_data_so_final")) {
  training_data_so_final <- readRDS(paste(dir_list$rds, "training_data_so_final.rds", sep = "/"))
}

library(AnnotationDbi)
library(org.Hs.eg.db)

## Functions

run_go_ora <- function(deg, bg_genes) {
  use_key <- "ENTREZID"
  base_key <- "SYMBOL"
  
  background <- mapIds(org.Hs.eg.db, 
                       keys = bg_genes, 
                       keytype = base_key, 
                       column = use_key) %>% 
    na.omit()
  
  gene_ids <- mapIds(org.Hs.eg.db, 
                     keys = deg, 
                     keytype = base_key, 
                     column = use_key) %>% 
    na.omit()
  
  ego <- clusterProfiler::enrichGO(gene = gene_ids,
                  OrgDb = org.Hs.eg.db,
                  keyType = use_key,
                  ont = "BP",
                  pAdjustMethod = "BH",
                  pvalueCutoff = 0.05,
                  universe = background,
                  readable = T)
  
  return(ego)
}

## Main

go_ora_list <- lapply(deg_filt_list, lapply, function(deg_list) {
  ora_obj <- run_go_ora(deg = rownames(deg_list), bg_genes = row.names(training_data_so_final))
  return(ora_obj)
})

saveRDS(go_ora_list, file = paste(dir_list$rds, "go_ora_list.rds", sep = "/"), compress = FALSE)
gc()
