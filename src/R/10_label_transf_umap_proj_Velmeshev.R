if(!exists("training_data_so_final_major_types")) {
  training_data_so_final_major_types <- readRDS(paste(dir_list$rds, "training_data_so_final_major_types.rds", sep = "/"))
}

## Functions
update_feature_names <- function(mat, meta_features) {
  rownames(mat) <- meta_features[rownames(mat), "feature_name"]
  mat
}

## Main

## Importing Velmeshev et al dataset
donor_ids_select <- c("5577", "5958", "5893", "5538", "5787", "5609", "5546", "5981", "RL2123", "RL2124", "RL2128", "RL2132")

velmeshev_data_so <- readRDS(paste(dir_list$data, "velmeshev_dataset_cellxgene_2024-12-17.rds", sep = "/"))

velmeshev_metadata <- data.table::fread(paste(dir_list$data, "velmeshev_dataset_metadata.csv", sep = "/"), data.table = FALSE)
rownames(velmeshev_metadata) <- velmeshev_metadata$Cell_ID
velmeshev_metadata <- velmeshev_metadata[rownames(velmeshev_data_so@meta.data),]

velmeshev_data_so <- AddMetaData(object = velmeshev_data_so, metadata = velmeshev_metadata)

## Preparing Velmeshev object for label transfer
velmeshev_data_so_major_types <- subset(velmeshev_data_so, donor_id %in% donor_ids_select)
velmeshev_data_so_major_types <- subset(velmeshev_data_so_major_types, cell_type != "unknown")

velmeshev_data_so_major_types@meta.data <- velmeshev_data_so_major_types@meta.data %>%
  mutate(cell_type = case_match(Lineage,
                                "OL" ~ "Oligodendrocytes",
                                "AST" ~ "Astrocytes",
                                "MG" ~ "Microglia",
                                "OPC" ~ "OPCs",
                                "ExNeu" ~ "Excitatory Neurons",
                                "IN" ~ "Inhibitory Neurons",
                                .default = Lineage),
         cell_type = factor(cell_type, levels = levels(training_data_so_final_major_types)))
Idents(velmeshev_data_so_major_types) <- "cell_type"

velmeshev_data_so_major_types@assays$RNA@counts <- update_feature_names(velmeshev_data_so_major_types@assays$RNA@counts, velmeshev_data_so_major_types@assays$RNA@meta.features)
velmeshev_data_so_major_types@assays$RNA@data <- update_feature_names(velmeshev_data_so_major_types@assays$RNA@data, velmeshev_data_so_major_types@assays$RNA@meta.features)

saveRDS(velmeshev_data_so_major_types, file = paste(dir_list$rds, "velmeshev_data_so_major_types.rds", sep = "/"), compress = FALSE)
rm(velmeshev_data_so, velmeshev_metadata)
gc()

## Label transfer
velmeshev_anchors <- FindTransferAnchors(reference = training_data_so_final_major_types, query = velmeshev_data_so_major_types, dims = 1:18, reference.reduction = "pca")
velmeshev_label_predictions <- TransferData(anchorset = velmeshev_anchors, refdata = training_data_so_final_major_types$cell_type, dims = 1:18)

velmeshev_data_so_major_types_predictions <- AddMetaData(velmeshev_data_so_major_types, velmeshev_label_predictions)

saveRDS(velmeshev_anchors, file = paste(dir_list$rds, "velmeshev_anchors.rds", sep = "/"), compress = FALSE)
saveRDS(velmeshev_data_so_major_types_predictions, file = paste(dir_list$rds, "velmeshev_data_so_major_types_predictions.rds", sep = "/"), compress = FALSE)
rm(velmeshev_data_so_major_types)
gc()

## UMAP projection
velmeshev_data_so_major_types_umap_proj <- MapQuery(anchorset = velmeshev_anchors, reference = training_data_so_final_major_types, query = velmeshev_data_so_major_types_predictions, refdata = list(celltype = "cell_type"), reference.dims = 1:18, reference.reduction = "pca", reduction.model = "umap")

saveRDS(velmeshev_data_so_major_types_umap_proj, file = paste(dir_list$rds, "velmeshev_data_so_major_types_umap_proj.rds", sep = "/"), compress = FALSE)
rm(velmeshev_data_so_major_types_umap_proj, velmeshev_data_so_major_types_predictions, velmeshev_anchors, velmeshev_label_predictions, training_data_so_final_major_types)
gc()




