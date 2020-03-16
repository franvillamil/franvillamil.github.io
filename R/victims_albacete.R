rm(list=ls())
setwd("~/Documents/Academic/PhD/Projects/Spain/data")
options(stringsAsFactors = FALSE)
library(muniSpain)

raw = read.csv("victims/raw_data/Albacete/vict_albacete_raw.csv")

# Fusilados & asesinados (n=3)
raw = subset(raw,
  Tipo %in% c("Muerto en cumplimiento de sentencia", "Muerto por asesinato"))

# Municipios by vecindad
raw$muni_vec = raw$Residencia
raw$muni_vec[raw$muni_vec == "Villar de Chinchilla"] = "Chinchilla de Monte-Aragon"
raw$muni_vec[raw$muni_vec == "La Gineta (Albacete)"] = "Gineta, La"
raw$muni_vec[raw$muni_vec == "Fuente Alamo"] = "Fuente-Alamo"
raw$muni_vec[raw$muni_vec == "Fuentealamo"] = "Fuente-Alamo"
raw$muni_vec[raw$muni_vec == "Almansa (Albacete)"] = "Almansa"
raw$muni_vec[raw$muni_vec == "La Roda"] = "Roda, La"
raw$muni_vec[raw$muni_vec == "Villarrobledo (Albacete)"] = "Villarrobledo"
raw$muni_vec[raw$muni_vec == "El Bonillo"] = "Bonillo, El"
raw$muni_vec[raw$muni_vec == "Chinchilla"] = "Chinchilla de Monte-Aragon"
raw$muni_vec[raw$muni_vec == "Minaya (Albacete)"] = "Minaya"
raw$muni_vec[raw$muni_vec == "Madrid"] = NA
raw$muni_vec[raw$muni_vec == "Castilblanco (Badajoz)"] = NA
raw$muni_vec[raw$muni_vec == "Penas de San Pedro (Albacete)"] = "Penas de San Pedro"
raw$muni_vec[raw$muni_vec == "Caudete (Albacete)"] = "Caudete"
raw$muni_vec[raw$muni_vec == "Alarcon"] = NA
raw$muni_vec[raw$muni_vec == "Almagro"] = NA
raw$muni_vec[raw$muni_vec == "Puerto Hurraco (Badajoz)"] = NA
raw$muni_vec[raw$muni_vec == "Turon (Oviedo)"] = NA
raw$muni_vec[raw$muni_vec == "Casas Ibanez"] = "Casas-Ibanez"
raw$muni_vec[raw$muni_vec == "Navas de la Concepcion (Sevilla)"] = NA
raw$muni_vec[raw$muni_vec == "Mahora (Albacete)"] = "Mahora"
raw$muni_vec[raw$muni_vec == "Alcaraz (Albacete)"] = "Alcaraz"
raw$muni_vec[raw$muni_vec == "Murcia"] = NA
raw$muni_vec[raw$muni_vec == "Munera (Albacete)"] = "Munera"
raw$muni_vec[raw$muni_vec == "Yeste (Albacete)"] = "Yeste"
raw$muni_vec[raw$muni_vec == "Liria (Valencia)"] = NA
raw$muni_vec[raw$muni_vec == "La Gineta"] = "Gineta, La"
raw$muni_vec[raw$muni_vec == "Molinicos (Yeste)"] = "Yeste"
raw$muni_vec[raw$muni_vec == "Villamalea (Albacete)"] = "Villamalea"
raw$muni_vec[raw$muni_vec == "Isso"] = "Hellin"
raw$muni_vec[raw$muni_vec == "Pozohondo (Albacete)"] = "Pozohondo"
raw$muni_vec[raw$muni_vec == "Alacala del Jucar"] = "Alcala del Jucar"
raw$muni_vec[raw$muni_vec == "Montealegre"] = "Montealegre del Castillo"
raw$muni_vec[raw$muni_vec == "Bonete (Albacete)"] = "Bonete"
raw$muni_vec[raw$muni_vec == "Minateda (Hellin)"] = "Hellin"
raw$muni_vec[raw$muni_vec == "Pozo Lorente"] = "Pozo-Lorente"
raw$muni_vec[raw$muni_vec == "Hellin (Albacete)"] = "Hellin"
raw$muni_vec[raw$muni_vec == "Estacion de Chinchilla"] = "Chinchilla de Monte-Aragon"
raw$muni_vec[raw$muni_vec == "Casas de Benitez"] = NA
raw$muni_vec[raw$muni_vec == "Silla (Valencia)"] = NA
raw$muni_vec[raw$muni_vec == "El Salobral"] = "Albacete"
raw$muni_vec[raw$muni_vec == "Sevilla"] = NA
raw$muni_vec[raw$muni_vec == "El Salobre"] = "Salobre"
raw$muni_vec[raw$muni_vec == "El Robledo"] = "Robledo"
raw$muni_vec[raw$muni_vec == "Sama de Langreo (Asturias)"] = NA
raw$muni_vec[raw$muni_vec == "Sege (Yeste, Albacete)"] = "Yeste"
raw$muni_vec[raw$muni_vec == "El Salobral (Albacete)"] = "Albacete"
raw$muni_vec[raw$muni_vec == "Barcelona"] = NA
raw$muni_vec[raw$muni_vec == "Valdeganga (Albacete)"] = "Valdeganga"
raw$muni_vec[raw$muni_vec == "Algemesi (Valencia)"] = NA
raw$muni_vec[raw$muni_vec == "Pozo Canada (Albacete)"] = "Pozo Canada"
raw$muni_vec[raw$muni_vec == "Reolid"] = "Salobre"
raw$muni_vec[raw$muni_vec == "Villaverde Alto (Madrid)"] = NA
raw$muni_vec[raw$muni_vec == "Santa Marta"] = "Roda, La"
raw$muni_vec[raw$muni_vec == "Vizcable"] = "Nerpio"
raw$muni_vec[raw$muni_vec == "Alicante"] = NA
raw$muni_vec[raw$muni_vec == "Corral-Rubio "] = "Corral Rubio"
raw$muni_vec[raw$muni_vec == "Rubielos de Mora"] = NA
raw$muni_vec[raw$muni_vec == "Pedro-Anton"] = NA
raw$muni_vec[raw$muni_vec == "Golosalvo (Albacete)"] = "Golosalvo"
raw$muni_vec[raw$muni_vec == "Tarazona de la Mancha (Albacete)"] = "Tarazona de la Mancha"
raw$muni_vec[raw$muni_vec == "La Encina"] = NA
raw$muni_vec[raw$muni_vec == "VillarEl Robledo"] = "Villarrobledo"
raw$muni_vec[raw$muni_vec == "Agramon (Hellin)"] = "Hellin"
raw$muni_vec[raw$muni_vec == "La Roda (Albacete)"] = "Roda, La"
raw$muni_vec[raw$muni_vec == "Lietor (Albacete)"] = "Lietor"
raw$muni_vec[raw$muni_vec == "Villarreal (Castellon)"] = NA
raw$muni_vec[raw$muni_vec == "Salmeron (Moratalla)"] = NA
raw$muni_vec[raw$muni_vec == "Chinchilla de Montearagon"] = "Chinchilla de Monte-Aragon"
raw$muni_vec[raw$muni_vec == "Ciudad Real"] = NA
raw$muni_vec[raw$muni_vec == "Cuenca"] = NA
raw$muni_vec[raw$muni_vec == "La Fuenlabrada (Albacete)"] = "Penascosa"
raw$muni_vec[raw$muni_vec == "Tarazona de La Mancha (Albacete)"] = "Tarazona de la Mancha"
raw$muni_vec[raw$muni_vec == "Toledo"] = NA
raw$muni_vec[raw$muni_vec == "Elche (Alicante)"] = NA
raw$muni_vec[raw$muni_vec == "Minas (Hellin)"] = "Hellin"
raw$muni_vec[raw$muni_vec == "Valencia"] = NA
raw$muni_vec[raw$muni_vec == "Cieza"] = NA
raw$muni_vec[raw$muni_vec == "El Jardin"] = "Alcaraz"
raw$muni_vec[raw$muni_vec == "Pozo Cananada (Albacete)"] = "Pozo Canada"
raw$muni_vec[raw$muni_vec == "Lorca (Murcia)"] = NA
raw$muni_vec[raw$muni_vec == "Cenizate (Albacete)"] = "Cenizate"
raw$muni_vec[raw$muni_vec == "Villena (Alicante)"] = NA
raw$muni_vec[raw$muni_vec == "Vitigudino (Salamanca)"] = NA
raw$muni_vec[raw$muni_vec == "Elda"] = NA
raw$muni_vec[raw$muni_vec == "Socuellamos (Ciudad Real)"] = NA
raw$muni_vec[raw$muni_vec == "Ossa de Montiel (Albacete)"] = "Ossa de Montiel"
raw$muni_vec[raw$muni_vec == "Jaen"] = NA
raw$muni_vec[raw$muni_vec == "Cordoba"] = NA
raw$muni_vec[raw$muni_vec == "Planez"] = NA

raw$muni_code = name_to_code(raw$muni_vec,
  prov = rep("albacete", length(raw$muni_vec)))

write.csv(raw, "victims_albacete.csv", row.names = FALSE)
