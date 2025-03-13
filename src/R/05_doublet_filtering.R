if(!exists("training_data_so_clust")) {
  training_data_so_clust <- readRDS(paste(dir_list$rds, "training_data_so_clust.rds", sep = "/"))
}

set.seed(seed_use)
bp <- BiocParallel::MulticoreParam(4, RNGseed = seed_use)

training_data_so_doublets <- training_data_so_clust %>% 
  as.SingleCellExperiment() %>% 
  scDblFinder::scDblFinder(samples = "orig.ident", clusters = "cell_type", BPPARAM = bp) %>% 
  as.Seurat()

training_data_so_final <- training_data_so_clust %>% subset(cells = WhichCells(training_data_so_doublets, expression = scDblFinder.class == "singlet"))

saveRDS(training_data_so_doublets, file = paste(dir_list$rds, "training_data_so_doublets.rds", sep = "/"), compress = FALSE)
saveRDS(training_data_so_final, file = paste(dir_list$rds, "training_data_so_final.rds", sep = "/"), compress = FALSE)

rm(bp, training_data_so_doublets, training_data_so_clust)
gc()