# Code originally provided by Kurt Hornik for aliases and rdxrefs db

## Build and install Rd aliases and xrefs dbs which can be used for
## checking Rd xrefs.
if(is_dir(file.path(package_dir, "man"))) {
    db <- tools::Rd_db(dir = package_dir)
    aliases <- lapply(db, tools:::.Rd_get_metadata, "alias")
    afile <- file.path(tmp_dir, "aliases.rds")
    saveRDS(aliases, file = afile, version = 2)
    safe_file_copy(afile,
                   file.path(package_web_dir, "aliases.rds"),
                   mode = "0664")
    message(" aliases", appendLF = FALSE)
    rdxrefs <- lapply(db, tools:::.Rd_get_xrefs)
    rdxrefs <- cbind(do.call(rbind, rdxrefs),
                     Source = rep.int(names(rdxrefs), sapply(rdxrefs, NROW)))
    xfile <- file.path(tmp_dir, "rdxrefs.rds")
    saveRDS(rdxrefs, file = xfile, version = 2)
    safe_file_copy(xfile,
                   file.path(package_web_dir, "rdxrefs.rds"),
                   mode = "0664")
    message(" rdxrefs", appendLF = FALSE)
}

#  package_dir is the path to the dir with all package web subdirs.
build_aliases_db <-
    function(package_dir, aliases_db_file, force = FALSE)
    {
        files <- Sys.glob(file.path(package_dir, "*", "aliases.rds"))
        packages <- basename(dirname(files))
        if(force || !is_file(aliases_db_file)) {
            db <- lapply(files, readRDS)
            names(db) <- packages
        } else {
            db <- readRDS(aliases_db_file)
            ## Drop entries in db not in package web area.
            db <- db[!is.na(match(names(db), packages))]
            ## Update entries for which aliases file is more recent than the
            ## db file.
            mtimes <- file.mtime(files)
            files <- files[mtimes >= file.mtime(aliases_db_file)]
            db[basename(dirname(files))] <- lapply(files, readRDS)
        }

        db[sort(names(db))]
    }
