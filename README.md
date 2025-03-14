Session Info:
=========================================================================================
R version 4.3.1 (2023-06-16)
Platform: aarch64-apple-darwin20 (64-bit)
Running under: macOS Ventura 13.2.1

Matrix products: default
BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
LAPACK: /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.11.0

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

time zone: Europe/Budapest
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices datasets  utils     methods   base     

other attached packages:
[1] SeuratObject_5.0.0 Seurat_4.4.0       ggplot2_3.4.4      stringr_1.5.0     
[5] tibble_3.2.1       tidyr_1.3.0        dplyr_1.1.3       

loaded via a namespace (and not attached):
  [1] RcppAnnoy_0.0.21        splines_4.3.1           later_1.3.1            
  [4] prismatic_1.1.2         ggplotify_0.1.2         bitops_1.0-7           
  [7] polyclip_1.10-6         janitor_2.2.0           lifecycle_1.0.3        
 [10] globals_0.16.2          lattice_0.22-5          MASS_7.3-60            
 [13] magrittr_2.0.3          rmarkdown_2.25          openxlsx_4.2.8         
 [16] plotly_4.10.3           yaml_2.3.7              httpuv_1.6.12          
 [19] sctransform_0.4.1       zip_2.3.2               spam_2.10-0            
 [22] sp_2.1-1                spatstat.sparse_3.0-3   reticulate_1.40.0      
 [25] cowplot_1.1.1           pbapply_1.7-2           DBI_1.1.3              
 [28] RColorBrewer_1.1-3      lubridate_1.9.3         abind_1.4-5            
 [31] zlibbioc_1.46.0         Rtsne_0.16              purrr_1.0.2            
 [34] ggraph_2.1.0            BiocGenerics_0.46.0     RCurl_1.98-1.12        
 [37] yulab.utils_0.1.0       tweenr_2.0.2            circlize_0.4.16        
 [40] GenomeInfoDbData_1.2.10 enrichplot_1.20.0       IRanges_2.34.1         
 [43] S4Vectors_0.38.2        ggrepel_0.9.4           irlba_2.3.5.1          
 [46] listenv_0.9.0           spatstat.utils_3.0-4    tidytree_0.4.5         
 [49] pheatmap_1.0.12         goftest_1.2-3           spatstat.random_3.2-1  
 [52] fitdistrplus_1.1-11     parallelly_1.36.0       svglite_2.1.3          
 [55] leiden_0.4.3            codetools_0.2-19        scCustomize_2.1.2      
 [58] ggforce_0.4.1           DOSE_3.26.2             tidyselect_1.2.0       
 [61] shape_1.4.6.1           aplot_0.2.2             farver_2.1.1           
 [64] viridis_0.6.4           matrixStats_1.0.0       stats4_4.3.1           
 [67] spatstat.explore_3.2-5  jsonlite_1.8.7          tidygraph_1.2.3        
 [70] ellipsis_0.3.2          progressr_0.14.0        ggridges_0.5.4         
 [73] survival_3.5-7          systemfonts_1.0.5       tools_4.3.1            
 [76] ragg_1.2.6              treeio_1.25.3           ica_1.0-3              
 [79] Rcpp_1.0.11             glue_1.6.2              gridExtra_2.3          
 [82] xfun_0.40               qvalue_2.32.0           GenomeInfoDb_1.36.4    
 [85] withr_2.5.1             BiocManager_1.30.22     fastmap_1.1.1          
 [88] fansi_1.0.5             digest_0.6.33           gridGraphics_0.5-1     
 [91] timechange_0.2.0        R6_2.5.1                mime_0.12              
 [94] textshaping_0.3.7       ggprism_1.0.5           colorspace_2.1-0       
 [97] scattermore_1.2         GO.db_3.17.0            tensor_1.5             
[100] spatstat.data_3.0-3     RSQLite_2.3.2           utf8_1.2.4             
[103] generics_0.1.3          renv_1.0.3              data.table_1.14.8      
[106] graphlayouts_1.0.1      httr_1.4.7              htmlwidgets_1.6.2      
[109] scatterpie_0.2.1        uwot_0.1.16             pkgconfig_2.0.3        
[112] gtable_0.3.4            blob_1.2.4              lmtest_0.9-40          
[115] XVector_0.40.0          shadowtext_0.1.2        clusterProfiler_4.8.2  
[118] htmltools_0.5.6.1       fgsea_1.26.0            dotCall64_1.1-0        
[121] scales_1.2.1            Biobase_2.60.0          png_0.1-8              
[124] snakecase_0.11.1        ggfun_0.1.3             knitr_1.44             
[127] rstudioapi_0.15.0       reshape2_1.4.4          nlme_3.1-163           
[130] zoo_1.8-12              cachem_1.0.8            GlobalOptions_0.1.2    
[133] KernSmooth_2.23-22      parallel_4.3.1          miniUI_0.1.1.1         
[136] vipor_0.4.5             HDO.db_0.99.1           AnnotationDbi_1.62.2   
[139] ggrastr_1.0.2           pillar_1.9.0            grid_4.3.1             
[142] vctrs_0.6.4             RANN_2.6.1              promises_1.2.1         
[145] xtable_1.8-4            cluster_2.1.4           beeswarm_0.4.0         
[148] paletteer_1.6.0         evaluate_0.22           cli_3.6.1              
[151] compiler_4.3.1          rlang_1.1.4             crayon_1.5.2           
[154] future.apply_1.11.0     labeling_0.4.3          rematch2_2.1.2         
[157] fs_1.6.3                plyr_1.8.9              forcats_1.0.0          
[160] ggbeeswarm_0.7.2        stringi_1.7.12          viridisLite_0.4.2      
[163] deldir_1.0-9            BiocParallel_1.34.2     munsell_0.5.0          
[166] Biostrings_2.68.1       lazyeval_0.2.2          spatstat.geom_3.2-7    
[169] GOSemSim_2.26.1         Matrix_1.6-1.1          patchwork_1.1.3        
[172] bit64_4.0.5             future_1.33.0           KEGGREST_1.40.1        
[175] shiny_1.7.5.1           ROCR_1.0-11             igraph_1.5.1           
[178] memoise_2.0.1           ggtree_3.9.1            fastmatch_1.1-4        
[181] bit_4.0.5               downloader_0.4          gson_0.1.0             
[184] ape_5.7-1  

===============================================================================