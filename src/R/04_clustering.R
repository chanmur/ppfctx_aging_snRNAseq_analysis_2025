if(!exists("training_data_so_harmony")) {
  training_data_so_harmony <- readRDS(paste(dir_list$rds, "training_data_so_harmony.rds", sep = "/"))
}

set.seed(seed_use)
training_data_so_clust <- training_data_so_harmony %>% 
  RunUMAP(dims = 1:39, reduction = "harmony", reduction.name = "umap_harmony", verbose = F, seed.use = 42) %>% 
  FindNeighbors(dims = 1:39, reduction = "harmony", verbose = F) %>% 
  FindClusters(resolution = 0.2, verbose = F)

training_data_so_clust <- RenameIdents(object = training_data_so_clust,
                                          "0" = "Oligodendrocytes",
                                          "1" = "Astrocytes",
                                          "2" = "Excitatory Neurons",
                                          "3" = "Microglia",
                                          "4" = "OPCs",
                                          "5" = "Inhibitory Neurons",
                                          "6" = "Inhibitory Neurons",
                                          "7" = "Excitatory Neurons",
                                          "8" = "Inhibitory Neurons",
                                          "9" = "Unspecified 1",
                                          "10" = "Inhibitory Neurons",
                                          "11" = "Excitatory Neurons",
                                          "12" = "Excitatory Neurons",
                                          "13" = "Unspecified 2",
                                          "14" = "Fibroblast-like Cells",
                                          "15" = "Excitatory Neurons",
                                          "16" = "Excitatory Neurons",
                                          "17" = "Astrocytes",
                                          "18" = "Endothelial Cells",
                                          "19" = "T Cells")

training_data_so_clust[["cell_type"]] <- Idents(training_data_so_clust)

saveRDS(training_data_so_clust, file = paste(dir_list$rds, "training_data_so_clust.rds", sep = "/"), compress = FALSE)

rm(training_data_so_harmony)
gc()