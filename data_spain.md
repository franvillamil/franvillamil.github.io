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

#### Catalonia and Aragon

Data on civilian victimization in Catalonia and Aragon, including direct violence by both rightist and leftist forces and victims of air shelling, can be found in the replication datasets of several articles written by Prof. Laia Balcells (Georgetown University), available at [her website](https://laiabalcells.com/).

#### Albacete

Victims from all over Castilla-La Mancha region can be found in the [website](http://victimasdeladictadura.es/) of an inter-university project (*Represión de guerra y postguerra en Castilla-La Mancha*) led by Prof. Manuel Ortiz Heras, at the University of Castilla-La Mancha. Even though the dataset includes victims from all provinces, the list is particularly comprehensive for the province of Albacete.

I have written R code to scrap, clean, and aggregate the data. [This script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_albacete_scrap.R) scraps the website and downloads individual-level data on all victims, while [this script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_albacete_clean.R) cleans and merges these data. Finally, [this script](https://github.com/franvillamil/franvillamil.github.io/blob/master/R/victims_albacete.R) subsets the data to those who suffer fatal, direct repression or executions and adds corresponding municipality codes.

#### Badajoz

### Prewar elections

### Trade unions
