---
layout: default
---

## Data and resources

- **[Github profile](https://github.com/franvillamil)** with replication datasets and code resources.

<br />

### Code

#### R package: Territorial changes in Spanish municipalities

<img src="https://raw.githubusercontent.com/franvillamil/franvillamil.github.io/master/files/muni_bilbao.png" width="475" />

The R package [muniSpain](https://github.com/franvillamil/munispain) is designed to deal with territorial changes in Spanish municipalities when working with historical local-level data from different periods.
It relies on the municipality codes from the [*Instituto Nacional de Estadística* (INE)](http://ine.es/) and the list of municipality changes compiled and corrected by Francisco J. Goerlich and Francisco Ruiz (see [Goerlich and Ruiz 2018](https://doi.org/10.1515/jos-2018-0005) and the package [readme file](https://github.com/franvillamil/muniSpain/blob/master/readme.md) for more information).
The package also allows converting municipality names (including old and multi-language denominations) to INE codes.
More information and installation on the [Github repository](https://github.com/franvillamil/munispain).

#### Scraping census data from INE

[R code](https://github.com/franvillamil/scrap-INE-census) to scrap census data from the [*Instituto Nacional de Estadística* (INE)](http://ine.es/)'s website.

#### Determining territorial origins of Spanish family names

[R code](https://gist.github.com/franvillamil/d0e81d059f8bfd1b87fe76ede9b47f34) to get the territorial origins of Spanish surnames from the [INE database](https://www.ine.es/widgets/nombApell/index.shtml), used to determined whether a family names is territorially concentrated in any region in Spain (see e.g. this [article](https://www.tandfonline.com/doi/abs/10.1080/13537113.2020.1795451?journalCode=fnep20) for an application). The scraping relies on [RSelenium](https://github.com/ropensci/RSelenium).

### Data

#### Spain

[Here](./data_spain.md) I offer details, R scripts and raw data on historical patterns of violence and political behavior in Spain.
It includes, among others, disaggregated data on civilian victimization during the Spanish Civil War, presence of trade unions in the 1930s or prewar electoral results.

### Other writing / software

- [Using R on a Google Cloud VM instance](./posts/R_google_vm.md)
- [Setting up a new macOS environment](./posts/setup_macos.md)

<br />
