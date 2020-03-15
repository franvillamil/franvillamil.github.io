setwd("~/Documents/Academic/PhD/Projects/Spain/data")
options(stringsAsFactors = FALSE)
Sys.setlocale("LC_CTYPE", "C")
library(muniSpain)

## PREPARING

# Read raw dataset
# raw = read.csv("base-datos.csv",
raw = read.csv("victims/raw_data/Galicia/datos_nomes_e_voces.csv",
  col.names = c("nombre", "apellidos", "apodo", "tipo", "sexo",
  "edad", "profesion", "concello_nat", "comarca_nat", "prov_nat", "lugar",
  "concello_vecino", "comarca_vecino", "prov_vecino", "fecha", "info"))
raw = adapt(raw[, c("nombre", "apellidos", "edad",
  "concello_vecino", "tipo", "fecha")])
raw$concello_vecino = tolower(raw$concello_vecino)
raw$tipo = tolower(raw$tipo)

## SUBSETTING

# Only victims with known death date
raw = subset(raw, fecha != "0000-00-00")
# NOTE: Data includes victims of non-fatal repression (did not die),
# that's why the high numbers sometimes.

# Transform to date class
raw$fecha = as.Date(raw$fecha, "%Y-%m-%d")

# Only 'paseos' and 'execucions'. Excluding deaths in prison and others.
raw = subset(raw, tipo %in% c("paseo", "execucion"))

# Exclude deaths after 1942 (0.2%)
raw = subset(raw, fecha <= "1942-12-31")

## ASSIGNING MUNICIPALITY CODES
# (Following place where victims lived)

# Exclude those without locality info
raw$concello_vecino[raw$concello_vecino %in% c("", "desconecido")] = NA
raw = subset(raw, !is.na(concello_vecino))

# Converting names
tmp = c("a estrada", "a pobra do caraminal", "o grove", "a coruna",
  "a caniza", "o porrino", "as neves", "a guarda", "o rosal", "o corgo",
  "a pontenova", "o barco de valdeorras", "o incio", "o savinao",
  "a pobra do brollon", "a fonsagrada", "as pontes de garcia rodriguez",
  "as somozas", "a mezquita", "a laracha", "o vicedo", "o pereiro de aguiar",
  "a arnoia", "a bana", "a rua", "a pobra de trives", "a gudina",
  "a veiga", "o carballino", "o irixo", "o bolo", "a pastoriza", "a lama")
raw$concello_vecino[raw$concello_vecino %in% tmp] = gsub("(a|o|as) (.*)", "\\2, \\1",
  raw$concello_vecino[raw$concello_vecino %in% tmp])
raw$concello_vecino[raw$concello_vecino == "a illa de arousa"] = "illa de arousa (a)"
raw$concello_vecino[raw$concello_vecino == "a merca"] = "merca , a"
