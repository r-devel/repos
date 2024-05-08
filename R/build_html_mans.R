
#' @examples
#'
#' bioc_sub <- c(
#'     "SummarizedExperiment", "Biobase", "BiocBaseUtils",
#'     "BiocGenerics", "DelayedArray", "GenomicRanges",
#'     "IRanges", "S4Vectors"
#' )
#'
#' ## generate from Bioc package source dirs
#' packages <- file.path(normalizePath("~/bioc"), bioc_sub)
#' src_base <- "~/minibioc/packages/3.20/bioc"
#'
#' build_html_mans(packages, src_base)
#'
#' @export
build_html_mans <- function(packages_dir, src_base) {
    packages <- basename(package_dir)
    html_dir <- file.path(base_dir, "manuals")
    if (!dir.exists(html_dir)) dir.create(html_dir, recursive = TRUE)
    outfiles <- file.path(html_dir, paste0(packages, ".html"))
    Map(
        tools::pkg2HTML,
        dir = packages_dir,
        out = outfiles
    )
}
