options(stringsAsFactors = FALSE)
Sys.setlocale("LC_CTYPE", "C")
library(muniSpain)

## RETRIEVING DATA AND PREPARING

# Download
url = "http://vitimas.nomesevoces.net/media/base-datos.csv"
file = "victims_galicia_raw.csv"
download.file(url, file)

# Load
data = read.csv("victims_galicia_raw.csv",
  col.names = c("nombre", "apellidos", "apodo", "tipo", "sexo",
  "edad", "profesion", "concello_nat", "comarca_nat", "prov_nat", "lugar",
  "concello_vecino", "comarca_vecino", "prov_vecino", "fecha", "info"))
data = adapt(data[, c("nombre", "apellidos", "edad",
  "concello_vecino", "prov_vecino", "tipo", "fecha")])
data$concello_vecino = tolower(data$concello_vecino)
data$prov_vecino = tolower(data$prov_vecino)
data$tipo = tolower(data$tipo)

## SUBSETTING

# Only victims with known death date
data = subset(data, fecha != "0000-00-00")
# NOTE: Data includes victims of non-fatal repression (did not die),
# that's why the high numbers sometimes.

# Transform to date class
data$fecha = as.Date(data$fecha, "%Y-%m-%d")

# Only 'paseos' and 'execucions'. Excluding deaths in prison and others.
data = subset(data, tipo %in% c("paseo", "execucion"))

# Exclude deaths after 1942 (0.2%)
data = subset(data, fecha <= "1942-12-31")

## ASSIGNING MUNICIPALITY CODES
# (Following place where victims lived)

# Exclude those without locality info
data$concello_vecino[data$concello_vecino %in% c("", "desconecido")] = NA
data = subset(data, !is.na(concello_vecino))

# Converting names
tmp = c("a estrada", "a pobra do caraminal", "o grove", "a coruna",
  "a caniza", "o porrino", "as neves", "a guarda", "o rosal", "o corgo",
  "a pontenova", "o barco de valdeorras", "o incio", "o savinao",
  "a pobra do brollon", "a fonsagrada", "as pontes de garcia rodriguez",
  "as somozas", "a mezquita", "a laracha", "o vicedo", "o pereiro de aguiar",
  "a arnoia", "a bana", "a rua", "a pobra de trives", "a gudina",
  "a veiga", "o carballino", "o irixo", "o bolo", "a pastoriza", "a lama")
data$concello_vecino[data$concello_vecino %in% tmp] = gsub("(a|o|as) (.*)", "\\2, \\1",
  data$concello_vecino[data$concello_vecino %in% tmp])
data$concello_vecino[data$concello_vecino == "a illa de arousa"] = "illa de arousa (a)"
data$concello_vecino[data$concello_vecino == "a merca"] = "merca, a"
# Missing province names
data$prov_vecino[data$concello_vecino == "corcubion" &
  data$prov_vecino == ""] = "a coruna"
data$prov_vecino[data$concello_vecino == "cee" &
  data$prov_vecino == ""] = "a coruna"
data$prov_vecino[data$concello_vecino == "mondariz-balneario" &
  data$prov_vecino == ""] = "pontevedra"
data$prov_vecino[data$concello_vecino == "fisterra" &
  data$prov_vecino == ""] = "a coruna"

# Assigning INE codes
data$muni_code = name_to_code(data$concello_vecino, prov = data$prov_vecino)

# Adapting to municipality changes between 1930 and 2011
data$muni_code = changes_newcode(data$muni_code, 1930, 2011)

write.csv(data, "victims_galicia.csv", row.names = FALSE)
