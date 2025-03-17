if(!exists("training_data_so_final")) {
  training_data_so_final <- readRDS(paste(dir_list$rds, "training_data_so_final.rds", sep = "/"))
}

if(!exists("frohlich_data_so_major_types")) {
  frohlich_data_so_major_types <- readRDS(paste(dir_list$rds, "frohlich_data_so_major_types.rds", sep = "/"))
}

if(!exists("velmeshev_data_so_major_types")) {
  velmeshev_data_so_major_types <- readRDS(paste(dir_list$rds, "velmeshev_data_so_major_types.rds", sep = "/"))
}

SeuratDisk::SaveH5Seurat(training_data_so_final, filename = paste(dir_list$docs, "training_data_so_final.h5seurat", sep = "/"), overwrite = TRUE, verbose = TRUE)
SeuratDisk::Convert(paste(dir_list$docs, "training_data_so_final.h5seurat", sep = "/"), dest = "h5ad")

SeuratDisk::SaveH5Seurat(frohlich_data_so_major_types, filename = paste(dir_list$docs, "frohlich_data_so_major_types.h5seurat", sep = "/"), overwrite = TRUE, verbose = TRUE)
SeuratDisk::Convert(paste(dir_list$docs, "frohlich_data_so_major_types.h5seurat", sep = "/"), dest = "h5ad")

SeuratDisk::SaveH5Seurat(velmeshev_data_so_major_types, filename = paste(dir_list$docs, "velmeshev_data_so_major_types.h5seurat", sep = "/"), overwrite = TRUE, verbose = TRUE)
SeuratDisk::Convert(paste(dir_list$docs, "velmeshev_data_so_major_types.h5seurat", sep = "/"), dest = "h5ad")