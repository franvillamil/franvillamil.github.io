### Setting up R on a Google Cloud VM instance

Steps to set up a Google Cloud instance to run R, including dependencies needed to install packages for spatial statistics (*Note*: it is much easier to run R on AWS, see [Louis Aslett's website](https://www.louisaslett.com/RStudio_AMI/)).

Instance details:

```shell
...@instance1:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.7 LTS
Release:	16.04
Codename:	xenial
```

A basic R installation:

```shell
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install r-base r-base-dev
```

However, by default, at least in my case, the only version of ```R``` available on the standard software sources is ```3.2.x```. To get ```R 4.0```:

```shell
# Install dependencies to add new repositories via HTTPS
sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
# Add CRAN repository, depending on Ubuntu flavor
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
```

Although in my case, it only work after I changed `https` to `http`. Edit the file (`sudo nano /etc/apt/sources.list`) and change last line to:

```shell
deb http://cloud.r-project.org/bin/linux/ubuntu xenial-cran40/
```

Install R:

```shell
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install r-base r-base-dev
```


Install the basic packages needed to run `rgdal`:

```shell
sudo apt-get install gdal-bin proj-bin libgdal-dev libproj-dev
```


The `spdep` package might require additional libraries (error message: `Configuration failed because libudunits2.so was not found`). To fix this:

```shell
sudo apt-get install libudunits2-dev
```

The `sf` package requires `GDAL 2.0.0`, which is not in the standard Ubuntu library. In this case, installing an older version of `sf` does not seem to work. The solution is to add [Ubuntu GIS unstable releases](https://launchpad.net/~ubuntugis/+archive/ubuntu/ubuntugis-unstable) to the system's software sources.

```shell
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install libgdal-dev
```

Alternatively, see [this thread](https://stackoverflow.com/questions/51367237/sf-r-package-is-not-compatible-with-gdal-versions-below-2-0-0-after-installing) on Stackoverflow.

One last thing. I often use `pdfcrop` to get rid of white margins in graphs (especially maps). It is not installed by default. To get it, install the `texlive-extra-utils` package:

```shell
sudo apt-get install texlive-extra-utils
```


**Sources**

- [Ubuntu Packages For R - Brief Instructions](https://cloud.r-project.org/bin/linux/ubuntu/)
- [How to upgrade R in ubuntu? [closed]](https://stackoverflow.com/questions/10476713/how-to-upgrade-r-in-ubuntu)
- [How to Install R on Ubuntu 20.04](https://linuxize.com/post/how-to-install-r-on-ubuntu-20-04/)
- [How to install the rgdal R package](https://gist.github.com/dncgst/111b74066eaea87c92cdc5211949cd1e)
- [rgdal won't install on AWS RStudio AMI](https://stackoverflow.com/questions/51173933/rgdal-wont-install-on-aws-rstudio-ami)
- [How to get GDAL >= 2.0.0 on Ubuntu 16.04 LTS?](https://askubuntu.com/questions/1068266/how-to-get-gdal-2-0-0-on-ubuntu-16-04-lts)
- [How to install pdfcrop in Ubuntu 14.04?](https://askubuntu.com/questions/864474/how-to-install-pdfcrop-in-ubuntu-14-04)
- [Installation of R 4.0 on Ubuntu 20.04 LTS and tips for spatial packages](https://rtask.thinkr.fr/installation-of-r-4-0-on-ubuntu-20-04-lts-and-tips-for-spatial-packages/)
