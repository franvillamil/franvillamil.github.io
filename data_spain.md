## Data resources for Spain

*(In progress.)*

* [Civilian victimization during the civil war](#civilian-victimization)
* [Electoral results in 1936 (and resources for 1933)](#prewar-elections)
* [Trade union presence during the 1930s](#trade-unions)

Most R scripts here, developed to clean and aggregate the raw data, use the [muniSpain R package](https://github.com/franvillamil/muniSpain).

### Civilian victimization

**Note:** If using any of this datasets, please cite the original source in each case. Unless I have explicit permission, I only post the tools to obtain the data from third-party sources.

#### Galicia

A list of all victims of Francoist repression in Galicia was compiled as part of the [*Nomes e Voces*](http://www.nomesevoces.net/) project, developed by several historical researchers at University of Santiago de Compostela, University of Vigo, and University of La Coruña, led by Lourenzo Fernández Prieto (USC). The raw data (CSV) can be download here: [http://vitimas.nomesevoces.net/](http://vitimas.nomesevoces.net/).

[This R script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_galicia.R) downloads the raw data and produces a municipality-level count of fatal victims of repression between 1936 and 1942, adapting municipalities to territorial changes between 1930 and 2011 censuses. (URL valid as of March 2020.)

#### Asturias

Data on civilian victimization in Asturias, which includes a comprehensive list of all those who died as a result of Francoist or Republican repression, was compiled as part of the project *Víctimas de la Guerra Civil y la Represión Franquista en Asturias,* led by Prof. Carmen García, at the University of Oviedo. The full database is available at the *Archivo Histórico de Asturias*, in Oviedo.

#### Basque Country

The Basque government offers a list of all disappeared persons durante the conflict and its aftermath, specifying the form of death and the origin of each victim. [This R script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_euskadi_scrap.R) scraps this website and downloads the list in CSV format, assigning standard INE codes to each municipality.

*Note* that the list might still be updated with new names, although its coverage is good. Moreover, as of March 2020, the website is down. The R script will be updated as soon as the website is active again. Contact me for more information.

#### Catalunya and Aragon

Data on civilian victimization in Catalonia and Aragon, including direct violence by both rightist and leftist forces and victims of air shelling, can be found in the replication datasets of several articles written by Prof. Laia Balcells (Georgetown University), available at [her website](https://laiabalcells.com/).

#### Albacete

Victims from all over Castilla-La Mancha region can be found in the [website](http://victimasdeladictadura.es/) of an inter-university project (*Represión de guerra y postguerra en Castilla-La Mancha*) led by Prof. Manuel Ortiz Heras, at the University of Castilla-La Mancha. Even though the dataset includes victims from all provinces, the list is particularly comprehensive for the province of Albacete.

I have written R code to scrap, clean, and aggregate the data. [This script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_albacete_scrap.R) scraps the website and downloads individual-level data on all victims, while [this script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_albacete_clean.R) cleans and merges these data. Finally, [this script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_albacete.R) subsets the data to those who suffer fatal, direct repression or executions and adds corresponding municipality codes.

#### Badajoz

A list of victims of civilian victimization in the province of Badajoz was compiled by Javier Martín Bastos, and it can be found in his doctoral dissertation 'Pérdidas de vidas humanas a consecuencia de las prácticas represivas franquistas en la provincia de Badajoz (1936-1950)' (2013, University of Extremadura), which is [available online](http://dehesa.unex.es/handle/10662/931). In addition, Candela Chaves Rodríguez has analyzed Francoist military justice in the same province as part of the doctoral dissertation (2014, University of Extremadura), and produced a list of all those who were sentenced during the war and postwar, which also includes non-fatal forms of repression. Chaves' dissertation is also [available online](http://dehesa.unex.es/handle/10662/1258).

In order to easily get the data on the number of people killed in each municipality, I have written this [R script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_badajoz.R), which downloads Martín Bastos' dissertation as a PDF and extracts the relevant data.

### Trade unions

#### UGT

The *Union General de los Trabajadores* (UGT) published a general census of all its local organizations, including the number of affiliates, as part of its official gazette in November 1931 (*Boletín no. 36 de la Unión General de Trabajadores*). These gazettes are available in the [historical archives](http://portal.ugt.org/fflc/biblioteca/archivo.htm) of the Fundación Largo Caballero, in Alcalá de Henares (Madrid).

I have digitized these data ([download as CSV](https://github.com/franvillamil/franvillamil.github.io/raw/master/files/ugt_1931.csv)) for a few selected regions: Galicia, Asturias, Basque Country, Navarra, Aragón, Catalonia, Albacete, and Badajoz. It shows the number of affiliates in each local trade union in each municipality, along with the year it was founded. The file does not show the name of the local union (i.e. the industry it represented), included in the original UGT gazettes.

#### CNT

Data on the presence of local unions affiliated to the anarchist *Confederación Nacional del Trabajo* (CNT) can be found in two published articles.
Cuco Giner (1970, ['Contribución a un estudio cuantitativo de la C.N.T.'](https://dialnet.unirioja.es/servlet/articulo?codigo=3785901)) includes data on local affiliates in 1931, while Juan Pablo Calero (2009, ['Vísperas de la revolución. El congreso de la CNT (1936)'](https://dialnet.unirioja.es/servlet/articulo?codigo=3785901).) offers a list of affiliates in 1936. Both articles are available online.

### Prewar elections

Getting data on electoral results during the 1930s in Spain is a bit of a mess. Results were counted and published separately for each province, and available sources change for each of them. In some cases, Official Provincial Gazettes (*Boletín Oficial Provincial*, BOP) published the detailed results (which might be available as scanned PDFs online or only at the local archives in paper form), but not in others: going through the all Provincial Gazettes of Pontevedra and A Coruña between February and July 1936, I did not find any data.

Here I put together different resources to obtain these data: references to sources, scanned BOPs and details about how I digitized some of them (including some that have not been digitized yet), R scripts, etc. My own [replication data](./research.md) and also [Laia Balcells'](https://laiabalcells.com/) includes municipality-level electoral results for 1936 for some provinces.

#### Galicia

To the best of my knowledge, local-level electoral results are only available for Lugo and Ourense provinces. The BOP in Pontevedra and A Coruña does not show any results, neither for 1936 nor for 1933. The vote count for each candidate is shown for each census section within municipalities.

I have taken pictures of 1933 and 1936 results for Lugo and Ourense (available upon request, as they are large files). In order to digitize some them, my solution was to use Python-based [OCRopus](https://github.com/tmbarchive/ocropy), but given the quality of the documents and pictures, new models to recognize the letters had to be trained and it needed both preprocessing and post-OCR manual corrections. Given the time it takes to do this, I have only had time to digitize the results for Lugo in 1936 [available here](https://github.com/franvillamil/franvillamil.github.io/blob/master/files/lugo1936.csv) (I coded the individual candidates as left/center-left/right following historical research, but it is open to debate in some small cases).

#### Asturias

Results for Asturias were published in a book by SADEI, *Atlas electoral de Asturias, 1936-1996* (1996, Oviedo: SADEI). [Here](https://github.com/franvillamil/franvillamil.github.io/blob/master/files/asturias1936.csv) is a CSV file including the results by municipality.

#### Basque Country

The Basque Country has the best available data on electoral results during the Second Republic. The regional government has digitized all the results for 1931, 1933, and 1936 elections from the Provincial Gazettes and made them [available online](https://www.euskadi.eus/web01-a2haukon/es/contenidos/informacion/w_em_republica/es_def/index.shtml).

This [R script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/elec36_euskadi.R) downloads the files for 1936 elections from the website of the Basque Government, cleans it, and produces a local-level dataset.

#### Catalunya

Detailed results for 1936 elections (and 1933, with the exception of the Barcelona province) are available in the book by Mercè Vilanova, *Atlas electoral de Catalunya durant la Segona República: orientació del vot, participació i abstenció* (1986, Barcelona: Fundació Jaume Bofill).

#### Aragón

See the [replication data](https://laiabalcells.com/) from Prof. Laia Balcells.

#### Albacete

Results for 1936 elections in the province of Albacete were published by Manuel Requena Gallego, in 'Las elecciones del Frente Popular en Albacete' (1982), [available online](https://dialnet.unirioja.es/servlet/articulo?codigo=1320408).

#### Others

In addition to the datasets mentioned above, I manage to collect the BOPs necessary to produce electoral datasets for a few more provinces or elections, even though I did not have the time to digitize them. They are large files so they are not available here, but are available by email: Sevilla and Badajoz in 1936, and Asturias in 1933 (not all municipalities).
