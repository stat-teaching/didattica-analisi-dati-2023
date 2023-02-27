# knit a single file
knit <- function(file, pdf = FALSE){
    html <- rmarkdown::render(file, quiet = TRUE)
    if(pdf){
        pagedown::chrome_print(html)
    }
    success(file)
}

# print message
success <- function(txt){
    filen <- cli::col_blue(basename(txt))
    cli::cli_alert_success(paste(txt, "compiled! :)"))
}

# warning
warn <- function(txt){
    cli::cli_alert_warning(txt)
}

knit_all <- function(path, exclude = c("README"), pdf = FALSE){
    files <- list.files(path, pattern = ".Rmd", full.names = TRUE, recursive = TRUE)
    files <- files[!grepl(paste0(exclude, collapse = "|"), files)]
    
    if(length(files) < 1){
        warn("No files to compile!")
    } else{
        purrr::walk(files, knit, pdf)
    }
}
