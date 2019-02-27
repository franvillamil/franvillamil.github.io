---
layout: default
---

-------------------

#### [About](./index.html) / [Research](./research.html) / [Data & Code](./data.html) / [CV](./files/cv.pdf)

-------------------

## Data and resources

### Code

#### R package `muniSpain`

[`muniSpain`](https://github.com/franvillamil/munispain) is an R package to deal with territorial changes in Spanish municipalities when working with historical local-level data from different periods.
It relies on the municipality codes from the [*Instituto Nacional de Estadística* (INE)](http://ine.es/) and the list of municipality changes compiled and corrected by Francisco J. Goerlich and Francisco Ruiz (see [Goerlich and Ruiz 2018](https://doi.org/10.1515/jos-2018-0005), and below for more information).
The package also allows converting municipality names (including old and multi-language denominations) to INE codes.

In particular, the strategy to deal with territorial changes in municipalities is that of ensuring that local-level datasets at any point in time during the period of interest can be aggregated together. This means that if municipalities A and B were at some point merged into a larger municipality Z, they will be merged for the whole period. Similarly, if D gained independence from C, the two municipalities will also be merged for the whole period.

#### Scraping census data from INE

[R code](https://github.com/franvillamil/scrap-INE-census) to scrap census data from the [*Instituto Nacional de Estadística* (INE)](http://ine.es/).

#### Data

- coming soon
