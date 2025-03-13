if(!exists("training_data_so_final")) {
  training_data_so_final <- readRDS(paste(dir_list$rds, "training_data_so_final.rds", sep = "/"))
}

## Preparing reference object

training_data_so_final_major_types <- subset(training_data_so_final, cell_type %in% c("Oligodendrocytes", "Microglia", "Astrocytes", "OPCs", "Excitatory Neurons", "Inhibitory Neurons"))
training_data_so_final_major_types <- RunUMAP(training_data_so_final_major_types, dims = 1:18, reduction = "pca", return.model = TRUE, reduction.name = "umap", seed.use = seed_use)

saveRDS(training_data_so_final_major_types, file = paste(dir_list$rds, "training_data_so_final_major_types.rds", sep = "/"), compress = FALSE)
rm(training_data_so_final)
gc()

## Importing Fröhlich et al dataset

## Note: If h5seurat file has not already been generated, uncomment the line below
# SeuratDisk::Convert(paste(dir_list$data, "frohlich_control.h5ad", sep = "/"), dest = "h5seurat")
frohlich_data_so <- SeuratDisk::LoadH5Seurat(paste(dir_list$data, "frohlich_control.h5seurat", sep = "/"), assays = "RNA", meta.data = FALSE)

frohlich_metadata <- data.table::fread(paste(dir_list$data, "frohlich_control_meta.csv", sep = "/"))
frohlich_metadata <- column_to_rownames(frohlich_metadata, var = "index")
frohlich_data_so <- AddMetaData(frohlich_data_so, metadata = frohlich_metadata)

saveRDS(frohlich_data_so, file = paste(dir_list$rds, "frohlich_data_so.rds", sep = "/"), compress = FALSE)

## Preparing Fröhlich object for label transfer
frohlich_data_so_major_types <- subset(frohlich_data_so, major_celltypes != "Endothelial")
frohlich_data_so_major_types@meta.data <- frohlich_data_so_major_types@meta.data %>% 
  mutate(major_celltypes_relabel = case_match(major_celltypes,
                                              "Oligodendrocyte" ~ "Oligodendrocytes",
                                              "Astrocytes" ~ "Astrocytes",
                                              "Microglia" ~ "Microglia",
                                              "OPC" ~ "OPCs",
                                              "Exc_Neurons" ~ "Excitatory Neurons",
                                              "In_Neurons" ~ "Inhibitory Neurons",
                                              .default = major_celltypes),
         major_celltypes_relabel = factor(major_celltypes_relabel, levels = unique(major_celltypes_relabel)))
Idents(frohlich_data_so_major_types) <- "major_celltypes_relabel"

frohlich_data_so_major_types <- frohlich_data_so_major_types %>% 
  NormalizeData(normalization.method = "LogNormalize", verbose = F) %>% 
  FindVariableFeatures(selection.method = "vst", 
                       nfeatures = 2000, 
                       verbose = F) %>%
  ScaleData(verbose = F) %>%
  RunPCA(features = VariableFeatures(.), 
         seed.use = seed_use,
         verbose = F) %>% 
  RunUMAP(dims = 1:13, reduction = "pca", seed.use = seed_use)

saveRDS(frohlich_data_so_major_types, file = paste(dir_list$rds, "frohlich_data_so_major_types.rds", sep = "/"), compress = FALSE)
rm(frohlich_data_so, frohlich_metadata)
gc()

## Label transfer
frohlich_anchors <- FindTransferAnchors(reference = training_data_so_final_major_types, query = frohlich_data_so_major_types, dims = 1:18, reference.reduction = "pca")
frohlich_label_predictions <- TransferData(anchorset = frohlich_anchors, refdata = training_data_so_final_major_types$cell_type, dims = 1:18)

frohlich_data_so_major_types_predictions <- AddMetaData(frohlich_data_so_major_types, frohlich_label_predictions)

saveRDS(frohlich_anchors, file = paste(dir_list$rds, "frohlich_anchors.rds", sep = "/"), compress = FALSE)
saveRDS(frohlich_data_so_major_types_predictions, file = paste(dir_list$rds, "frohlich_data_so_major_types_predictions.rds", sep = "/"), compress = FALSE)
rm(frohlich_data_so_major_types)
gc()

## UMAP projection
frohlich_data_so_major_types_umap_proj <- MapQuery(anchorset = frohlich_anchors, reference = training_data_so_final_major_types, query = frohlich_data_so_major_types_predictions, refdata = list(celltype = "cell_type"), reference.dims = 1:18, reference.reduction = "pca", reduction.model = "umap")

saveRDS(frohlich_data_so_major_types_umap_proj, file = paste(dir_list$rds, "frohlich_data_so_major_types_umap_proj.rds", sep = "/"), compress = FALSE)
rm(frohlich_data_so_major_types_umap_proj, frohlich_data_so_major_types_predictions, frohlich_label_predictions, frohlich_anchors)
gc()



