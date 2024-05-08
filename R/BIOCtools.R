.LOCAL_BIOC_SRC_BASE <- normalizePath("~/minibioc/packages/3.20/bioc")

BIOC_local_src_area <-
    function(src_base = .LOCAL_BIOC_SRC_BASE)
        paste0("file:///", src_base)

BIOC_aliases_db <-
    function()
        tools:::read_CRAN_object(
            BIOC_local_src_area(), "src/contrib/Meta/aliases.rds"
        )

BIOC_rdxrefs_db <-
    function()
        tools:::read_CRAN_object(
            BIOC_local_src_area(), "src/contrib/Meta/rdxrefs.rds"
        )
