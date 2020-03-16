options(stringsAsFactors = FALSE)
library(rvest)
library(stringr)

# SETTING UP

# Encoding issues
unicode = function(x){
  x = gsub("\u00d1", "N", x) #	Ñ
  x = gsub("\u00c7", "C", x) #	Ç
  x = gsub("\u00c0", "A", x) #	À
  x = gsub("\u00c1", "A", x) #	Á
  x = gsub("\u00c4", "A", x) #	Ä
  x = gsub("\u00c8", "E", x) #	È
  x = gsub("\u00c9", "E", x) #	É
  x = gsub("\u00cc", "I", x) #	Ì
  x = gsub("\u00cd", "I", x) #	Í
  x = gsub("\u00cf", "I", x) #	Ï
  x = gsub("\u00d2", "O", x) #	Ò
  x = gsub("\u00d3", "O", x) #	Ó
  x = gsub("\u00d6", "O", x) #	Ö
  x = gsub("\u00d9", "U", x) #	Ù
  x = gsub("\u00da", "U", x) #	Ú
  x = gsub("\u00db", "U", x) #	Û
  x = gsub("\u00dc", "U", x) #	Ü
  x = gsub("\u00f1", "n", x) #	ñ
  x = gsub("\u00e7", "c", x) #	ç
  x = gsub("\u00e0", "a", x) #	à
  x = gsub("\u00e1", "a", x) #	á
  x = gsub("\u00e4", "a", x) #	ä
  x = gsub("\u00e8", "e", x) #	è
  x = gsub("\u00e9", "e", x) #	é
  x = gsub("\u00ec", "i", x) #	ì
  x = gsub("\u00ed", "i", x) #	í
  x = gsub("\u00ef", "i", x) #	ï
  x = gsub("\u00f2", "o", x) #	ò
  x = gsub("\u00f3", "o", x) #	ó
  x = gsub("\u00f6", "o", x) #	ö
  x = gsub("\u00f9", "u", x) #	ù
  x = gsub("\u00fa", "u", x) #	ú
  x = gsub("\u00fb", "u", x) #	û
  x = gsub("\u00fc", "u", x) #	ü
  return(x)
}

# Number of pages
pages = read_html("http://www.victimasdeladictadura.es/buscador-filtros") %>%
  html_nodes(".pager-current") %>%
  html_text()
pages = as.integer(gsub("1 de ", "", pages)) - 1

# Getting URLs
url = "http://victimasdeladictadura.es/buscador-filtros?field_nombre_value=&field_apellidos_value=&field_sexo_value=All&field_natural_de_value=&field_residencia_value=&field_profesion_concreta_value=&field_partido_value=&field_filiacion_sindical_value=&field_cargo_publico_value=&items_per_page=20&page="
url = paste0(url, 0:pages)

# SCRAPPING

# Create folder
dir.create("raw_fichas")

# LOOP 1: For each page, get links, navigate, and extract info
# (LIMITED TO ALBACETE)
for(i in 582:length(url)){
  # Print status
  print(paste0(i, "/", pages+1))
  # Getting links
  links = read_html(url[i]) %>%
    html_nodes("h5 a") %>%
    html_attr("href")
  # Only Albacete victims
  links = links[grepl("-AB-", links)]

  # If no Albacete people, go to next iteration
  # Otherwise, build dataframe
  if(length(links) == 0){
    next
  } else {
    df = data.frame(nombre = NULL, info = NULL, info = NULL, label = NULL)
  }

  # LOOP 2: For each link, extract information
  for(j in links){
    # build url
    link_url = paste0("http://www.victimasdeladictadura.es", j)
    # get information
    id = read_html(link_url) %>%
      html_nodes("h1") %>%
      html_text()
    head = read_html(link_url) %>%
      html_nodes(".span8 h2") %>%
      html_text()
    info = read_html(link_url) %>%
      html_nodes(".span8 .even") %>%
      html_text()
    label = read_html(link_url) %>%
      html_nodes(".span8 .field-label") %>%
      html_text()
    # if one less label than info
    if (length(info) == length(label) + 1){
      label = c("Tipo: ", label)}
    # to string
    info = paste(info, collapse = "\n")
    label = paste(label, collapse = "\n")
    # append
    df = rbind(df, data.frame(nombre = unicode(id), head = unicode(head),
      label = unicode(label), info = unicode(info)))
  }

  # write page-specific info
  write.csv(df, paste0("raw_fichas/page", i, ".csv"), row.names = FALSE)

}
