# NOTE: Old script, could probably be fixed using dplyr
options(stringsAsFactors = FALSE)
Sys.setlocale("LC_CTYPE", "C")
library(muniSpain)
library(car)
library(plyr)

# ----------------------------------
## Functions

# Download and load into R
download_load = function(url){
  download.file(url, destfile = "tmp.csv")
  tmp = read.csv2("tmp.csv")
  file.remove("tmp.csv")
  return(tmp)
}

# Clean datasets
results_by_party = function(df){

  # Change candidate/party names
  old = names(df)
  for (i in c("Ind", "PSOE", "Ren..Esp", "(Ctrad|CTrad|Com.Trad)",
    "Uni..Rep", "(Izq..Rep|IR)", "PRR", "CEDA", "PNV", "PCE")){
    pattern = paste0(".*\\.", i, "\\..*")
    names(df) = gsub(pattern, i, names(df))
  }
  # Simplify other column names
  names(df) = recode(names(df),
    "'PUEBLOS' = 'muni'; 'Ayuntamientos' = 'muni';
    'N.mero.de.electores.que.han.votado' = 'total_electores';
    'N..electores.que.han.votado' = 'total_electores';
    'N.mero.de.votos.emitidos' = 'total_votos';
    'N.mero.de.Electores.de.cada.secci.n' = 'total_electores';
    'En.Blanco' = 'blanco'; 'VOTOS.EN.BLANCO' = 'blanco';
    'VOTOS.SUELTOS' = 'otros'; 'Varios' = 'otros';
    'Diversos.y.en.blanco' = 'blanco/otros';
    '(Ctrad|CTrad|Com.Trad)' = 'CTrad';
    'Ren..Esp' =  'RE';
    'Uni..Rep' =  'UR';
    '(Izq..Rep|IR)' = 'IR'")
  df$muni = adapt(df$muni, tolower = TRUE)
  # Compare
  print(cbind(old, new=names(df)))
  # Transpose
  df2 = as.data.frame(t(df[,-1]))
  for (i in 1:ncol(df2)){
    df2[,i] = gsub("\\.", "", df2[,i])
    df2[,i] = as.integer(df2[,i])}
  df2 = cbind(party=gsub("\\.[1-9]", "", rownames(df2)), df2)
  # Aggregate by party name
  df2 = ddply(df2, .(party),
    function(x) colSums(x[,-1], na.rm = TRUE))
  # Transpose again and assign muni names
  df3 = as.data.frame(t(df2[,-1]))
  names(df3) = df2$party
  df3 = cbind(muni = df$muni, df3)
  # Return
  return(df3)

}

# ----------------------------------
## Load into R, clean and merge

# Load
bilbao = download_load("https://www.euskadi.eus/web01-a2haukon/es/contenidos/informacion/w_em_contexto_historico_1936/es_def/result_1936/csv/mun_bizkaia_capital_1936_feb_c.csv")
bizkaia = download_load("https://www.euskadi.eus/web01-a2haukon/es/contenidos/informacion/w_em_contexto_historico_1936/es_def/result_1936/csv/mun_bizkaia_provincia_1936_feb_c.csv")
alava = download_load("https://www.euskadi.eus/web01-a2haukon/es/contenidos/informacion/w_em_contexto_historico_1936/es_def/result_1936/csv/mun_araba_1936_feb_c.csv")
gipuzkoa = download_load("https://www.euskadi.eus/web01-a2haukon/es/contenidos/informacion/w_em_contexto_historico_1936/es_def/result_1936/csv/mun_gipuzkoa_1936_feb_c.csv")

# Clean individual files
bilbao = cbind(results_by_party(bilbao), prov = "bizkaia")
bizkaia = cbind(results_by_party(bizkaia), prov = "bizkaia")
alava = cbind(results_by_party(alava), prov = "alava")
gipuzkoa = cbind(results_by_party(gipuzkoa), prov = "gipuzkoa")

# Merge
data = rbind.fill(bilbao, bizkaia, alava, gipuzkoa)

# Rearrange columns
data = data[, c("muni", "prov", "CEDA", "CTrad",
  "Ind", "IR", "PCE", "PNV", "PSOE", "RE", "UR",
  "PRR", "otros", "blanco/otros", "blanco", "total_electores")]

# ----------------------------------
## Fix municipality codes

# Get parties
parties = names(data)[!names(data) %in%
  c("muni", "prov", "total_electores")]
# Fill blanks
for(i in parties){
  data[ is.na(data[,i]) ,i] = 0
}
# Remove totals from gazettes
data = subset(data, !muni %in% c("total  boletin", "total boletin"))
# Add municipality total number of votes
data$total_votos = rowSums(data[, parties])

# Fix a few municipality names
data$muni[data$muni == "s. salvador del valle" &
  data$prov == "bizkaia"] = "san salvador del valle"
data$muni[data$muni == "santurce (a)" &
  data$prov == "bizkaia"] = "santurce-antiguo"
data$muni[data$muni == "santurce (o)" &
  data$prov == "bizkaia"] = "santurce-ortuella"
data$muni[data$muni == "guernica y lumo" &
  data$prov == "bizkaia"] = "gernika-lumo"
data$muni[data$muni == "los huetos" &
  data$prov == "alava"] = "huetos, los"
data$muni[data$muni == "villarreal-legutio" &
  data$prov == "alava"] = "villarreal de alava"
data$muni[data$muni == "villarreal-urretxu" &
  data$prov == "gipuzkoa"] = "villarreal de urrechu"
data$muni[data$muni == "vedia" &
  data$prov == "bizkaia"] = "bedia"
data$muni[data$muni == "axpe y marzana" &
  data$prov == "bizkaia"] = "axpe"
data$muni[data$muni == "olaverria" &
  data$prov == "gipuzkoa"] = "olaberria"

# Assign municipality codes
data = cbind(muni_code = name_to_code(data$muni, data$prov), data)

# Fix municipality codes for those municipalites with exact
# same name but different codes (INE issue): assigning old code
data$muni_code[data$muni == "erandio" & data$prov == "bizkaia"] = "48516"
data$muni_code[data$muni == "zamudio" & data$prov == "bizkaia"] = "48534"
data$muni_code[data$muni == "derio" & data$prov == "bizkaia"] = "48513"
data$muni_code[data$muni == "forua" & data$prov == "bizkaia"] = "48518"
data$muni_code[data$muni == "murueta" & data$prov == "bizkaia"] = "48529"
data$muni_code[data$muni == "astigarraga" & data$prov == "gipuzkoa"] = "20502"
data$muni_code[data$muni == "baliarrain" & data$prov == "gipuzkoa"] = "20504"
data$muni_code[data$muni == "gaztelu" & data$prov == "gipuzkoa"] = "20506"
data$muni_code[data$muni == "orendain" & data$prov == "gipuzkoa"] = "20513"

# ----------------------------------
## Save
write.csv(data, "euskadi_elec1936.csv", row.names = F)
