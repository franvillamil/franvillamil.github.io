options(stringsAsFactors = FALSE)
library(stringr)
library(plyr)

## PREPARATION
# Getting page files
f = list.files("raw_fichas/")
f = f[order(as.integer(gsub("page(.*).csv", "\\1", f)))]
f = paste0("victims/raw_data/Albacete/raw_fichas/", f)
# Merge
df_list = lapply(f, function(x) read.csv(x))
if(any(sapply(df_list, function(x) ncol(x)) != 4)){
  stop("problem with ncol")} else {
  data = as.data.frame(do.call("rbind", df_list))}
# Removing people without information
data = subset(data, head != " .")

## SPLITTING VARIABLES
info = str_split(data$info, "\n")
info_n = sapply(info, function(x) length(x))
label = str_split(data$label, "\n")
label_n = sapply(label, function(x) length(x))

# Some observaciones are split in several lines
for(i in which(info_n != label_n)){
  diff = info_n[i] - label_n[i]
  obs = which(grepl("Observaciones", label[[i]]))
  merge = seq(obs, obs+diff, 1)
  remove = merge[!merge %in% obs]
  info[[i]][obs] = paste(info[[i]][merge], collapse = " ")
  info[[i]] = info[[i]][-remove]
}

# Remove final : from labels & change spaces
label = lapply(label, function(x) gsub("(: |: )$", "", x))
label = lapply(label, function(x) gsub(" ", "_", x))

# Turn into a list of dataframes
### (is it possible to do with lapply?)
for(i in 1:length(info)){
  info[[i]] = t(data.frame(info[[i]], row.names = label[[i]]))
  info[[i]] = as.data.frame(info[[i]])
  row.names(info[[i]]) = i
}

# Transform to data frame and order (just in case)
info_df = as.data.frame(do.call("rbind.fill", info))
info_df = info_df[order(as.integer(row.names(info_df))),]

# Put everything together
data = cbind(data[, c("nombre", "head")], info_df)

# Add info on birthplace if available
data$head = gsub("\\.$", "", data$head)
data$Natural_de = gsub(".*natural de ", "", data$head)
data$Natural_de = gsub("( y m| \\().*", "", data$Natural_de)
data$Natural_de[!grepl("natural", data$head)] = NA

# Add info on death date
data$Fecha_muerte = gsub(".*murio el dia ", "", data$head)
data$Fecha_muerte[!grepl("murio", data$head)] = NA
data$Fecha_muerte = as.Date(data$Fecha_muerte, "%d/%m/%Y")

# Clean a couple things
data$Tipo[data$Tipo %in% c("Muerto en cumplimento de sentencia",
  "Muerto en cumplimineto de sentencia")] =
  "Muerto en cumplimiento de sentencia"
data$Tipo[data$Tipo == "prision"] = "Prision"

### SAVE DATA
write.csv(data, "victims_albacete_raw.csv", row.names = FALSE)
