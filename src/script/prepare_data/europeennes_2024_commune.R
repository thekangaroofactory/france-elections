

europeennes_2024_commune <- function(){
  
  # -- param
  pattern <- "europeennes"
  
  # -- read data
  dataset <- readr::read_delim("data/Europeennes_2024_commune.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
  
  # -- define
  cols_before <- c("Code département",
                   "Libellé département",
                   "Code commune",
                   "Libellé commune",
                   "Inscrits",
                   "Votants",
                   "% Votants",
                   "Abstentions",
                   "% Abstentions",
                   "Exprimés",
                   "% Exprimés/inscrits",
                   "% Exprimés/votants",
                   "Blancs",
                   "% Blancs/inscrits",
                   "% Blancs/votants",
                   "Nuls",
                   "% Nuls/inscrits",
                   "% Nuls/votants")
  
  cols_candidate <- c("Numéro de panneau",
                      "Nuance liste",
                      "Libellé abrégé de liste",
                      "Libellé de liste",
                      "Voix",
                      "% Voix/inscrits",
                      "% Voix/exprimés",
                      "Sièges")
  
  RAW_COLS_TO_DROP <- c("% Votants",
                        "% Abstentions",
                        "% Exprimés/inscrits",
                        "% Exprimés/votants",
                        "% Blancs/inscrits",
                        "% Blancs/votants",
                        "% Nuls/inscrits",
                        "% Nuls/votants",
                        "% Voix/inscrits",
                        "% Voix/exprimés",
                        "Sièges")
  
  # -- duplicate before transform
  data <- dataset
  
  # -- prepare
  # warning: this line does not work   colnames(data) <- c(names(cols_before), names(cols_candidate))
  # Replace by this >> colnames(data) <- c(cols_before, cols_candidate)
  # dataset_by_candidate <- prepare_by_candidates2(dataset, pattern, cols_before, cols_candidate)
  

  # -- Code commune
  # Fix code 1001 because it should be 1 (they added departement before)
  
  #data$`Code commune` <- substr(data$`Code commune`, nchar(data$`Code commune`) - 3 + 1, nchar(data$`Code commune`))
  

  # -- fix  
  data$codgeo.commune <- data$`Code commune`
  data$`Nom.Tête.de.Liste` <- data$`Libellé abrégé de liste`
  
  # -- rename
  colnames(data) <- c("Code.du.département",
                      "Libellé.du.département",
                      "Code.de.la.commune",
                      "Libellé.de.la.commune",
                      "Inscrits",
                      "Votants",
                      "Abstentions",
                      "Exprimés",
                      "Blancs",
                      "Nuls",
                      "N.Liste",
                      "Nuance liste",
                      "Libellé.Abrégé.Liste",
                      "Libellé.Etendu.Liste",
                      "Voix",
                      "codgeo.commune",
                      "Nom.Tête.de.Liste")
  
  # -- save
  save_csv(path = "data/prepared/", file = "Europeennes_2024_commune.txt", data)
  
}
