
#' @examples
#'
#' library(BiocPkgTools)
#' bioc_sub <- pkgBiocDeps(
#'     "SummarizedExperiment", pkgType = "software",
#'     recursive = TRUE, only.bioc = TRUE
#' )
#' bioc_sub <- unlist(bioc_sub, use.names = FALSE)
#'
#' ## generate from Bioc package source dirs
#' packages <- file.path(normalizePath("~/bioc"), bioc_sub)
#' src_base <- "~/minibioc/packages/3.20/bioc"
#'
#' build_html_mans(packages, src_base)
#'
#' @export
build_html_mans <- function(package_dirs, src_base) {
    packages <- basename(package_dirs)
    html_dir <- file.path(src_base, "manuals")
    if (!dir.exists(html_dir)) dir.create(html_dir, recursive = TRUE)
    outfiles <- file.path(html_dir, paste0(packages, ".html"))
    Map(
        tools::pkg2HTML,
        dir = package_dirs,
        out = outfiles
    )
}
