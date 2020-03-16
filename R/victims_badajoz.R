# NOTE: URL valid as of March 2013. If it has changed,
# just download the file manually and assign the name below.
options(stringsAsFactors = FALSE)
library(muniSpain)
library(stringr)
library(pdftools)
library(plyr)
library(reshape2)
library(tidyr)

## PREPARE

# Downloading PDF
url = "http://dehesa.unex.es/bitstream/handle/10662/931/TDUEX_2013_Martin_Bastos.pdf?sequence=1&isAllowed=y"
download.file(url, "TDUEX_2013_Martin_Bastos.pdf")

# Reading PDF into text
pdf = pdf_text("TDUEX_2013_Martin_Bastos.pdf")

# We only want chapter 3: pp 109-942 (105-938 in PDF)
pdf = pdf[105:938]

# Split into lines and delete initial spaces
text = strsplit(pdf, "\n")
text = lapply(text, function(x) x = gsub("^\\s+", "", x))

# Join all pages of PDF
text = adapt(unlist(text))

## EXTRACT DATA

# Identify municipality chapters (str: 3.4.12. TALARRUBIAS) (n=155)
muni_names = text[grepl("3\\.\\d+\\.\\d+", text)]
# remove Carrascalejo and Trasierra y Reina (RECOVER LATER!)
muni_names = muni_names[!grepl("CARRASCALEJO", muni_names)]
muni_names = muni_names[!grepl("TRASIERRA Y REINA", muni_names)]

# Detect tables
tables_str = which(grepl("Total\\s+19\\d\\d", text))
tables_end = which(grepl("Total\\s+\\d+", text))
tables_end = tables_end[!tables_end %in% tables_str]

# Create list, fill with table lines
# (n=154, Carrascalejo no table -- only one death)
muni_tables = as.list(muni_names)
for(i in 1:length(muni_tables)){muni_tables[[i]] = c(muni_tables[[i]],
  text[tables_str[i]:tables_end[i]])}

# Manual corrections
muni_tables[[8]] = gsub(
  "Prision               1      -    -     -    -      -   -     -    -              1",
  "Prision               1      -    -     -    -      -   -     -    -       -      1",
  muni_tables[[8]])
muni_tables[[38]] = gsub(
  "Paseos              11      10       1",
  "Paseos              11      10       1    -",
  muni_tables[[38]])
muni_tables[[61]] = gsub(
  "Guerrilla            5                                       5",
  "Guerrilla            5     -    -    -    -   5   -",
  muni_tables[[61]])
muni_tables[[72]] = gsub(
  "Pena capital        1      -      -   -      1",
  "Pena capital        1      -      -   -      1   -",
  muni_tables[[72]])
muni_tables[[97]] = gsub(
  "Paseos     50      48       1        1",
  "Paseos     50      48       1        1   -",
  muni_tables[[97]])
muni_tables[[100]] = gsub(
  "Otras muertes     4    -   -    1            -      1    -   -   2     -    -   -",
  "Otras muertes     4    -   -    1     -      -      1    -   -   2     -    -   -",
  muni_tables[[100]])
muni_tables[[103]] = gsub(
  "Otras muertes      1                               1",
  "Otras muertes      1     -     -     -   1",
  muni_tables[[103]])
muni_tables[[117]] = gsub(
  "Pena capital          1       -               1      -      -",
  "Pena capital          1       -       -       1      -      -",
  muni_tables[[117]])
muni_tables[[131]] = gsub(
    "Pena capital  10       -     5       1       3                1      -   -",
    "Pena capital  10       -     5       1       3       -       1      -   -",
    muni_tables[[131]])
muni_tables[[143]] = gsub(
  "Desaparecidos       17              2       6      -     -    -     -      9",
  "Desaparecidos       17      -       2       6      -     -    -     -      9",
  muni_tables[[143]])
muni_tables[[18]] = gsub(
  "Prision               1      -    -     -    -      -   -     -    -              1",
  "Prision               1      -    -     -    -      -   -     -    -      -       1",
  muni_tables[[18]])
muni_tables[[68]] = gsub(
  "Guerrilla           5                       2      1      1      1        -",
  "Guerrilla           5       -        -      2      1      1      1        -",
  muni_tables[[68]])

# Function to transform lines into data frame
lines_to_df = function(x){
  mname = x[1]
  x[2] = paste0("Tipo      ", x[2])
  x = gsub("Pena capital|Pena Capital", "Pena_capital", x)
  x = gsub("Otras causas", "Otras_causas", x)
  x = gsub("Otras muertes", "Otras_muertes", x)
  x = gsub("S\\. E\\.|S\\.E\\.", "No_Year", x)
  x = str_split(x, "\\s+")
  x = matrix(unlist(x[-1]), ncol = length(x[[2]]), byrow = TRUE)
  cnames = x[1,]
  x = as.data.frame(x[2:nrow(x),])
  names(x) = cnames
  x$muni = mname
  return(x)
}

## CLEAN

muni_tables = lapply(muni_tables, function(x) lines_to_df(x))
data = do.call("rbind.fill", muni_tables)

# Reorder and clean
data = data[,-which(names(data) == "Total")]
data = gather(data, key = "year", value = "victims",
  c("1936", "1937", "1938", "1939", "1940", "1941", "1942", "1943",
  "1944", "1945", "1946", "1947", "1948", "1949", "1950", "No_Year"))
data$victims[is.na(data$victims) | data$victims == "-"] = 0
data$victims = as.integer(data$victims)
data$Tipo[data$Tipo == "Otras_causas"] = "Otras_muertes"
data = spread(data, Tipo, victims, fill = 0)

# Only year with victims
data = subset(data, Total > 0)

# Clean municipality name
data$muni = tolower(gsub("(3\\.\\d+\\.\\d+(\\.|) )|(\\d+$)", "", data$muni))

# Add non-existent tables:
# CARRASCALEJO
# "No tenemos constancia de ninguna muerte que se pueda achacar a la violencia revolucionaria y solamente documentamos un fusilamiento por parte del bando franquista: el de Juan Manuel Almirante Carrasco, casado y con 4 hijos, que fue pasado por las armas en ese municipio el 8 de septiembre del mismo año [1936]."
data = rbind(data,
  data.frame(muni = "el carrascalejo", year = "1936", Paseos = 1, Total = 1,
  Desaparecidos = 0, Guerrilla = 0, Otras_muertes = 0, Pena_capital = 0, Prision = 0))
# RISCO, BATERNO, TAMUREJO
# "En Baterno nos encontramos con un vecino fallecido en prisión: Fructuoso Agudo Expósito, muerto en Castuera el 25 de abril de 1941. ... En Tamurejo tenemos que hablar de una víctima por cada una de los dos bandos. ... Y por parte de la franquista: Remigio Camarero Caballo, muerto en la prisión de Castuera el 9 de abril de 1941."
data = rbind(data,
  data.frame(muni = "baterno", year = "1941", Paseos = 0, Total = 1,
  Desaparecidos = 0, Guerrilla = 0, Otras_muertes = 0, Pena_capital = 0, Prision = 1),
  data.frame(muni = "tamurejo", year = "1941", Paseos = 0, Total = 1,
  Desaparecidos = 0, Guerrilla = 0, Otras_muertes = 0, Pena_capital = 0, Prision = 1))
# TRASIERRA Y REINA

# "En Reina ... En cuanto a las víctimas que dejo la violencia franquista fueron dos en prisión: Fernando Cabrera Bernal, de 64 años, que falleció en la prisión de Trujillo el 3 de noviembre de 1940; y José Hernández Rodríguez, muerto en la prisión de Castuera el 27 de abril de 1941."

# "En lo que respecta a Trasierra, tampoco hemos constatado ninguna víctima provocada por la violencia republicana, siendo dos las defunciones que se pueden achacar a la violencia franquista, ambas por la práctica de los paseos: Cipriano Gato Carreño, de 44 años, fusilado en Llerena el 21 de noviembre de 1936; y Eulogio Cordero Sancho, de 46 años, pasado por las armas en Villanueva del Duque (Córdoba) el 10 de marzo de 1937."
data = rbind(data,
  data.frame(muni = rep(c("trasierra", "reina"), each = 4),
  year = c("1936", "1937", "1940", "1941"),
  Paseos = c(1,1,0,0), Prision = c(0,0,1,1), Total = c(1,1,1,1),
  Desaparecidos = rep(0, 4), Guerrilla = rep(0, 4),
  Otras_muertes = rep(0, 4), Pena_capital = rep(0, 4)) )

# RE-DO TOTAL (some mistakes in some places)
data$Total = with(data, Paseos + Prision + Desaparecidos +
  Guerrilla + Otras_muertes + Pena_capital)

## ASSIGN MUNICIPALITY CODES

# Corrections
data$muni[data$muni == "valencia del mombuey"] = "valencia de mombuey"
data$muni[data$muni == "zarza capilla"] = "zarza-capilla"
data$muni = gsub("(^la|^el|^los) (.*)", "\\2, \\1", data$muni)

# Assign municipality codes
data$muni_code = name_to_code(data$muni,
  prov = rep("badajoz", length(data$muni)))

# Year to integer, unknown to NA
data$year = as.integer(data$year)

## SAVE

write.csv(data, "victims/raw_data/Badajoz/badajoz_victims_detalle.csv", row.names=F)
