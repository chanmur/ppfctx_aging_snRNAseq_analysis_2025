if(!exists("training_data_so_final")) {
  training_data_so_final <- readRDS(paste(dir_list$rds, "training_data_so_final.rds", sep = "/"))
}

# Scaling all genes for heatmaps
training_data_so_final_scaled <- ScaleData(training_data_so_final, features = row.names(training_data_so_final))

saveRDS(training_data_so_final_scaled, paste(dir_list$rds, "training_data_so_final_scaled.rds", sep = "/"), compress = FALSE)
rm(training_data_so_final_scaled)
gc()

# Finding top genes expressed in each of the different cell types in the dataset
training_data_all_markers <- FindAllMarkers(training_data_so_final)

saveRDS(training_data_all_markers, paste(dir_list$rds, "training_data_all_markers.rds", sep = "/"), compress = FALSE)
rm(training_data_all_markers)
gc()


