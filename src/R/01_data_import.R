## Functions
fetch_sample_info <- function(sample, var) {
  return(cohort_meta %>% filter(sample_name == sample) %>% pull(var))
}


# Importing cohort metadata
cohort_meta <- data.table::fread(paste(dir_list$data, "training_cohort_metadata.csv", sep = "/"), data.table = FALSE)

# Important cell ranger output files
mat_files <- list.files(dir_list$data, pattern = "\\.tar\\.gz$", full.names = TRUE)

training_data_list <- list()

training_data_list$mat_data <- list()
training_data_list$seurat_objects <- list()

for (file in mat_files) {
  
  extract_path <- gsub("\\.tar\\.gz$", "", file)
  
  # Extracting corresponding sample information to add as metadata later
  sample_name <- tail(str_split_1(extract_path, "/"), 1)
  
  sample_id <- fetch_sample_info(sample_name, "sample_id")
  age <- fetch_sample_info(sample_name, "age")
  sex <- fetch_sample_info(sample_name, "sex")
  pmi <- fetch_sample_info(sample_name, "pmi")
  cause_of_death <- fetch_sample_info(sample_name, "cause_of_death")
  brain_region <- fetch_sample_info(sample_name, "brain_region")
  pre_manifest_ad <- fetch_sample_info(sample_name, "pre_manifest_ad")
  age_group <- fetch_sample_info(sample_name, "age_group")
  sequencing_batch <- fetch_sample_info(sample_name, "sequencing_batch")
  
  # Extracting compressed files
  untar(tarfile = file, exdir = dir_list$data)
  
  # Creating dgc matrix from raw data and adding them to the raw data list 
  training_data_list$mat_data[[sample_id]] <- Read10X(extract_path, strip.suffix = TRUE)
  
  colnames(training_data_list$mat_data[[sample_id]]) <- paste(sample_id, 
                                                            colnames(training_data_list$mat_data[[sample_id]]), 
                                                            sep = "-")
  
  # Creating Seurat Object from the dgc matrices
  training_data_list$seurat_objects[[sample_id]] <- CreateSeuratObject(counts = training_data_list$mat_data[[sample_id]], 
                                                                   project = "ppfc_ageing_snRNAseq", 
                                                                   names.field = 1, 
                                                                   names.delim = "-")
  
  # Adding metadata to the Seurat Object
  training_data_list$seurat_objects[[sample_id]]@meta.data  <- training_data_list$seurat_objects[[sample_id]]@meta.data %>% 
    mutate("sample_name" = rep(sample_name),
           "sample_id" = rep(sample_id),
           "age" = rep(age),
           "sex" = rep(sex),
           "pmi" = rep(pmi),
           "cause_of_death" = rep(cause_of_death),
           "brain_region" = rep(brain_region),
           "pre_manifest_ad" = rep(pre_manifest_ad),
           "age_group" = rep(age_group),
           "sequencing_batch" = rep(sequencing_batch))
}

training_data_so <- merge(training_data_list$seurat_objects[[1]], y = training_data_list$seurat_objects[c(2:length(training_data_list$seurat_objects))], project = "ppfc_ageing_snRNAseq")

saveRDS(cohort_meta, file = paste(dir_list$rds, "cohort_meta.rds", sep = "/"), compress = FALSE)
saveRDS(training_data_list, file = paste(dir_list$rds, "training_data_list.rds", sep = "/"), compress = FALSE)
saveRDS(training_data_so, file = paste(dir_list$rds, "training_data_so.rds", sep = "/"), compress = FALSE)

rm(training_data_list)
gc()