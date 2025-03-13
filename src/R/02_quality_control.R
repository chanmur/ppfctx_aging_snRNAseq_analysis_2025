if(!exists("training_data_so")) {
  training_data_so <- readRDS(paste(dir_list$rds, "training_data_so.rds", sep = "/"))
}

training_data_so_qc <- training_data_so

training_data_so_qc[["percent.mt"]] <- PercentageFeatureSet(training_data_so, pattern = "^MT-")
training_data_so_qc[["percent.rb"]] <- PercentageFeatureSet(training_data_so_qc, pattern = "^RP[SL][[:digit:]]|^RPLP[[:digit:]]|^RPSA")

training_data_so_qc$log10GenesPerUMI <- log10(training_data_so_qc$nFeature_RNA) / log10(training_data_so_qc$nCount_RNA)

training_data_so_qc_filt <- training_data_so_qc %>% 
  subset(nCount_RNA > 1200 & nCount_RNA < 100000 & nFeature_RNA > 800 & nFeature_RNA < 12000 & percent.mt < 5)

saveRDS(training_data_so_qc, file = paste(dir_list$rds, "training_data_so_qc.rds", sep = "/"), compress = FALSE)
saveRDS(training_data_so_qc_filt, file = paste(dir_list$rds, "training_data_so_qc_filt.rds", sep = "/"), compress = FALSE)

rm(training_data_so, training_data_so_qc)
gc()