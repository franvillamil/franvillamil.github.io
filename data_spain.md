## Data resources for Spain

Currently including:

* [Civilian victimization during the civil war](#civilian-victimization)
* [Electoral results in 1936 (and resources for 1933)](#prewar-elections)
* [Trade union presence during the 1930s](#trade-unions)

*(In progress.)*

**Note:** most R scripts here, developed to clean and aggregate the raw data, use the [muniSpain R package](https://github.com/franvillamil/muniSpain).

### Civilian victimization

#### Galicia

A list of all victims of Francoist repression in Galicia was compiled as part of the [*Nomes e Voces*](http://www.nomesevoces.net/) project, developed by several historical researchers at University of Santiago de Compostela, University of Vigo, and University of La Coruña, led by Lourenzo Fernández Prieto (USC). The raw data (CSV) can be download here: [http://vitimas.nomesevoces.net/](http://vitimas.nomesevoces.net/).

[This R script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_galicia.R) downloads the raw data and produces a municipality-level count of fatal victims of repression between 1936 and 1942, adapting municipalities to territorial changes between 1930 and 2011 censuses. (URL valid as of March 2020.)

#### Asturias

Data on civilian victimization in Asturias, which includes a comprehensive list of all those who died as a result of Francoist or Republican repression, was compiled as part of the project *Víctimas de la Guerra Civil y la Represión Franquista en Asturias,* led by Carmen García, Professor of History at the University of Oviedo. The full database is available at the *Archivo Histórico de Asturias*, in Oviedo.

#### Basque Country

The Basque government offers a list of all disappeared persons durante the conflict and its aftermath, specifying the form of death and the origin of each victim. [This R script](./R/scrap_victims_euskadi.R) scraps this website and downloads the list in CSV format, assigning standard INE codes to each municipality.

*Note* that the list might still be updated with new names, although its coverage is good. Moreover, as of March 2020, the website is down. The R script will be updated as soon as the website is active again. A CSV file with the data scraped in late 2017 can be found [here](https://github.com/franvillamil/franvillamil.github.io/blob/master/files/vict_euskadi.csv).

#### Catalonia and Aragon

### Prewar elections

### Trade unions

Data on civilian victimization in Catalonia and Aragon, including direct violence by both rightist and leftist forces and victims of air shelling, can be found in the replication datasets of several articles written by Prof. Laia Balcells, available at [her website](https://laiabalcells.com/).

#### Albacete

#### Badajoz