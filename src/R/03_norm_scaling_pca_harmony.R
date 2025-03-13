if(!exists("training_data_so_qc_filt")) {
  training_data_so_qc_filt <- readRDS(paste(dir_list$rds, "training_data_so_qc_filt.rds", sep = "/"))
}

set.seed(seed_use)
training_data_so_harmony <- training_data_so_qc_filt %>% NormalizeData(verbose = F) %>% 
  FindVariableFeatures(selection.method = "vst", nfeatures = 2000, verbose = F) %>%
  ScaleData(verbose = F) %>%
  RunPCA(features = VariableFeatures(.), seed.use = seed_use, verbose = F)
  
set.seed(seed_use)
training_data_so_harmony <- harmony::RunHarmony(training_data_so_harmony, c("sequencing_batch", "orig.ident"), plot_convergence = TRUE)

saveRDS(training_data_so_harmony, file = paste(dir_list$rds, "training_data_so_harmony.rds", sep = "/"), compress = FALSE)

rm(training_data_so_qc_filt)
gc()