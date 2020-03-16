# NOTE (March 2020):
# - Website is currently down because of updates
# - Script needs to be updated to get municipality
#   codes using muniSpain package (province?)

options(stringsAsFactors = FALSE)

library(rvest)
library(RCurl)
library(stringr)
library(muniSpain)

# Create URLs vector
URLs = paste0("http://www.euskadi.eus/web01-s1lehmem/es/contenidos/informacion/listado_personas_desaparecidas/es_memoria/",
  letters, "_listado_personas_desaparecidas.html")

# Retrieve data
data = data.frame()
for (i in URLs){
    print(i)
    table = i %>%
      read_html() %>%
      html_nodes(xpath='//*[@id="containers1lehmem_eduki_orokorra"]/div[2]/table') %>%
      html_table(fill = TRUE)
    table = table[[1]]
    data = rbind(data, table)
}

# Col names and correct encoding
names(data)[names(data) == "Lugar Muerte"] = "Lugar_Muerte"
data$Vecindad = unicode(data$Vecindad)
data$Lugar_Muerte = unicode(data$Lugar_Muerte)

# Fix non aligned columns
i = data$Fecha %in% c("Desaparecido", "Fusilado", "Muerto Frente", "Muerto Prision")
data$Modo[i] = data$Fecha[i]
data$Fecha[i] = NA
i = grepl("\\d/", data$Lugar_Muerte) & is.na(data$Fecha)
data$Fecha[i] = data$Lugar_Muerte[i]
data$Lugar_Muerte[i] = data$Vecindad[i]
data$Vecindad[i] = NA

# Correct date
data$Fecha = gsub("-", "/", data$Fecha)
data$Fecha[str_length(data$Fecha) == 0] = NA
data$Fecha[data$Fecha %in% c("1936.0", "1936")] = "18/07/1936"
data$Fecha[data$Fecha == "Mayo 1937"] = "01/05/1937"
data$Fecha[data$Fecha == "2/12/1936"] = "02/12/1936"
data$Fecha[data$Fecha == "??/06/1937"] = "01/06/1937"
data$Fecha = as.Date(data$Fecha, "%d/%m/%Y")

# Only with known date and municipality
data = subset(data, !is.na(Fecha) & Vecindad != "" & !is.na(Vecindad))

# Get census municipio
c = subset(read.csv("census/INE_census.csv"),
  prov_name %in% c("bizkaia", "alava", "gipuzkoa") & !is.na(c1930),
  select = c("prov_code", "prov_name", "muni_code", "muni_name", "c1930"))

# 1. Exact
data$muni_name30 = c$muni_name[match(data$Vecindad, c$muni_name)]
data$muni_code30 = c$muni_code[match(data$Vecindad, c$muni_name)]

data$muni_name30[data$Vecindad == "Iurre"] = "Igorre"
data$muni_name30[data$Vecindad == "Murga"] = "Ayala/Aiara"

# 2. Agrepl
log_agrepl = vector()
for (i in which(is.na(data$muni_name30))){
  match = agrepl(data$Vecindad[i], c$muni_name, ignore.case = TRUE)
  if (length(match[match]) == 1){
    log_agrepl = c(log_agrepl, paste0(data$Vecindad[i], " matched with ", c$muni_name[match]))
    data$muni_name30[i] = c$muni_name[match]
    data$muni_code30[i] = c$muni_code[match]
  } else if (length(match[match]) > 1){
    log_agrepl = c(log_agrepl,
      paste0("Possible matches for ", data$Vecindad[i], ": ",
        paste(c$muni_name[match], collapse = ", ") ))
  }
}

# Avoid mistakes
mistaken =  c("Burgos", "Zamora", "Liria", "Sobas", "Alban", "Llanes", "Nules",
  "Itsasu", "Fios", "Jaen", "Orgaz", "Caniego", "Polan", "Segovia",
  "Arcedo", "Sevilla", "Caseda", "Marauri", "Tarrasa", "Portugal",
  "Labiena", "Elche", "Cuba", "Gares")
data$muni_name30[data$Vecindad %in% mistaken] = NA
data$muni_code30[data$Vecindad %in% mistaken] = NA

# 3. Manual checking
vec_id = c("Gallarta", "Murrieta", "Pagoeta", "Zornotza", "Baranbio",
  "Saratxo", "Delika", "Artomana", "Larrinbe (Araba)", "Olaeta",
  "Araminon", "Maeztu", "Apenaniz", "Gorozika", "Arratzu", "Luko",
  "Gaztelu Elexabeitia", "Castillo Elejabeitia", "Arcentales",
  "Mendieta", "Araia", "Egino", "Murelaga", "Marono", "Anes(Araba)",
  "Arespalditza", "Sojo", "Olabezar", "Errespalditza", "Luiando",
  "Aiara", "Urrestilla", "Alonsotegi", "Ozaeta", "Badonl De La Sierra",
  "Okina", "Larraskitu", "Lutxana", "Artxanda", "Deustu", "Zorroza",
  "Olabeaga", "Begona", "Bolibar", "Ziortza Bolibar", "Zearrotza",
  "Zamakola", "Altza", "Anorga", "Iurreta", "Etxano", "Maltzaga",
  "Eltziego", "Erribera Goitia", "Rigoitia", "Etxabarri", "Ezkio-Itxaso",
  "Gernika", "V. De Luno", "Lumo", "Las Arenas", "Neguri", "Algorta",
  "Sodupe", "Zaramillo", "V. Karrantza", "Bastida", "Biasteri",
  "Asua", "Laukiniz", "Elosu", "Lamiako", "Arminza", "Loiu", "Markina",
  "Barinaga", "Larrauri", "Langraiz Oka", "Nondarona", "Plencia",
  "Eguskiza", "Komunioi", "Lantaron", "Galarreta", "Kanpezu", "Santurce",
  "San Andres", "Ugao", "Belandia", "Orudna", "Unza", "Ondona (Araba)",
  "Oiardo", "Izarra", "Gurendes", "Villanueva", "Karkamu", "Nograro",
  "San Salvador Del Valle", "La Arboleda", "San Salvador", "Zuhatzu",
  "Minano Mayor", "Subijana", "Villafranca", "Zuazo", "Derio",
  "Akozta", "Arkotza", "Akosta")
vec_correction = c("Abanto y Ciervana - Abanto Zierbena", "Abanto y Ciervana - Abanto Zierbena",
  "Aia", "Amorevieta", "Amurrio", "Amurrio", "Amurrio", "Amurrio",
  "Amurrio", "Aramaio", "Arminon", "Arraya", "Arraya", "Arrazua de Vizcaya",
  "Arrazua de Vizcaya", "Arrazua Ubarrundia", "Artea", "Artea",
  "Artzentales", "Artziniega", "Asparrena", "Asparrena", "Aulesti",
  "Ayala/Aiara", "Ayala/Aiara", "Ayala/Aiara", "Ayala/Aiara", "Ayala/Aiara",
  "Ayala/Aiara", "Ayala/Aiara", "Ayala/Aiara", "Azpeitia", "Barakaldo",
  "Barrundia", "Basauri", "Bernedo", "Bilbao", "Bilbao", "Bilbao",
  "Bilbao", "Bilbao", "Bilbao", "Bilbao", "Cenarruza", "Cenarruza",
  "Cenarruza", "Dima", "Donostia - San Sebastian", "Donostia - San Sebastian",
  "Durango", "Echano", "Eibar", "Elciego", "Erriberagoitia / Ribera Alta",
  "Errigoiti", "Etxebarri", "Ezquioga", "Gernika-Lumo", "Gernika-Lumo",
  "Gernika-Lumo", "Getxo", "Getxo", "Getxo", "Guenes", "Guenes",
  "Karrantza Harana / Valle de Carranza", "Labastida/Bastida",
  "Laguardia", "Larrabetzu", "Laukiz", "Legutio", "Leioa", "Lemoiz",
  "Lujua", "Marquina", "Marquina", "Mungia", "Nanclares de Oca",
  "Pasaia", "Plentzia", "Portugalete", "Salcedo", "Salcedo", "San Millan/Donemiliaga",
  "Santa Cruz de Campezo", "Santurtzi", "Soraluze / Placencia de las Armas",
  "Ugao - Miraballes", "Urduna/Orduna", "Urduna/Orduna ", "Urkabustaiz",
  "Urkabustaiz", "Urkabustaiz", "Urkabustaiz", "Valdegovia/Gaubea",
  "Valdegovia/Gaubea", "Valdegovia/Gaubea", "Valdegovia/Gaubea",
  "Valle de Trapaga - Trapagaran", "Valle de Trapaga - Trapagaran",
  "Valle de Trapaga - Trapagaran", "Vitoria-Gasteiz", "Vitoria-Gasteiz",
  "Vitoria-Gasteiz", "Vitoria-Gasteiz", "Vitoria-Gasteiz", "Zamudio Derio",
  "Zaratamo", "Zaratamo", "Zigoitia")
data$muni_name30[is.na(data$muni_name30)] =
  vec_correction[match(data$Vecindad[is.na(data$muni_name30)], vec_id)]
data$muni_code30 = c$muni_code[match(data$muni_name30, c$muni_name)]


write.csv(data, "victims_euskadi.csv", row.names = FALSE)
