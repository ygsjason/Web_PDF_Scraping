library(tidyverse)
library(data.table)
library(pdftools)

# Cancer diagnoses --------------------------------------------------------
accopdd <- list.files("J:/Fake Files/Downloads/",
                      pattern = "Chronic", full.names = TRUE) %>%
  .[!str_detect(.,"~")] %>% 
  map(pdf_text) %>%
  flatten_chr() %>%
  str_split("(\n|\r)") %>%
  flatten_chr() %>%
  trimws() %>%
  str_subset("^(J\\d+)") %>%
  str_extract_all("J\\d{2,}")

copd <- c(map_chr(accopdd, `[`, 1), map_chr(accopdd, `[`, 2)) %>% .[!is.na(.)]
