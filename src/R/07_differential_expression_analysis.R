if(!exists("training_data_so_final")) {
  training_data_so_final <- readRDS(paste(dir_list$rds, "training_data_so_final.rds", sep = "/"))
}

## Functions
filter_deg <- function(deg_df, remove_genes) {
  deg_df <- deg_df %>% 
    filter(p_val_adj < 0.05 & abs(avg_log2FC) > 0.5) %>% 
    filter(!grepl("^A[A-Z][0-9]+\\.[0-9]$|^MT-",
                  rownames(.))) %>% 
    filter(!(rownames(.) %in% remove_genes)) %>% 
    arrange(desc(avg_log2FC))
  
  return(deg_df)
}

## Main
cell_types <- c("Oligodendrocytes", "Microglia", "Astrocytes", "OPCs", "Excitatory Neurons", "Inhibitory Neurons")

comp_list <- c("Old vs Young", "Old vs Middle Age", "Middle Age vs Young")

sex_genes_list <- data.table::fread(paste(dir_list$data, "X_Y_gene_list_hg38_GrCh38.p14_2025_02_26.txt", sep = "/"), data.table = FALSE)
  
deg_list <- lapply(setNames(comp_list, comp_list), function(comp) {
  age_groups <- str_split_1(comp, " vs ")
  
  deg_per_cell_type <- lapply(setNames(cell_types, cell_types), function(cell_type) {
    deg <- FindMarkers(object = training_data_so_final,
                       ident.1 = age_groups[1],
                       ident.2 = age_groups[2],
                       group.by = "age_group",
                       subset.ident = cell_type,
                       test.use = "wilcox")
    
    return(deg)
  })
  
  return(deg_per_cell_type)
})

deg_filt_list <- lapply(deg_list, lapply, filter_deg, remove_genes = sex_genes_list$`Gene name`)

saveRDS(deg_list, file = paste(dir_list$rds, "deg_list.rds", sep = "/"), compress = FALSE)
saveRDS(deg_filt_list, file = paste(dir_list$rds, "deg_filt_list.rds", sep = "/"), compress = FALSE)

rm(cell_types, comp_list, sex_genes_list, deg_list)
gc()
