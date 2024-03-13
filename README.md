
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Estimating costs and benefits of alternative IPS beyond SMI scenarios - code repository

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

<!-- badges: end -->

## Introduction

The purpose of this repository is to provide reproducible code and raw
data inputs to produce the parameters used in the cost-benefit modelling
of Individual Placement and Support (IPS) programmes for individuals
with mental health and musculoskeletal problems.

## Usage

Fork the project on GitHub to create your own repository. This project
uses [`renv`](https://rstudio.github.io/renv/articles/renv.html) to aid
reproducibility of results by ensuring users make use of the same
environment.

When a new user first launches in this project, `renv` should
automatically bootstrap itself, thereby downloading and installing the
appropriate version of `renv` into the project library. After this has
completed, they can then use `renv::restore()` to restore the project
library locally on their machine. Once the project library is restored,
the repository is ready to be used to replicate the analysis once the
requirements below are met.

There are five stages to the analysis

1.  Defining the eligible population by local authority.
2.  Obtaining labour market parameters.
3.  Calibrating labour market transition probabilities for the treatment
    effect.
4.  Calculating EQ-5D health utilities.
5.  Obtaining income, tax, and benefit profiles.

## Reproducibility

Note that this repository uses the renv R package to produce a
reproducible environment for this analysis. see the [package
website](https://rstudio.github.io/renv/articles/renv.html) for more
information.

When first launching the project, the function `renv::restore()` will
populate the `renv/library` folder, installing the R packages saved in
the lockfifle.

The lockfile `renv.lock` is in the top level of the repository, and
contains the metadata for all R packages used in the project. The
libraries themselves are ignored by git and not uploaded to GitHub, and
so a new user needs to install the packages themselves using the
metadata.

The .Rprofile file in the top level of the repository is automatically
run when the project is opened and this runs the script file
`renv/activate.R` to set the renv folder as the source R package
library.

The version of R used to produce the analysis is 4.3.1.

## Requirements

Use of the project requires access to various datasets which are
obtained through the UK Data Service. These must be downloaded in tab
delimited form and the raw data files placed in the relevant folder in
the `data` folder. The datasets required are:

- Health Survey for England (HSE) 2018

- Understanding Society (USoc) waves 1-13

- Family Resources Survey (FRS) 2018/19 - 2021/22

- Labour Force Survey (LFS)

  - Five-quarter longitudinal datasets from AJ12-AJ13 to JM22-JM23

  - Cross-sectional quarterly datasets from JM15 to OD23

The fifth stage of the analysis involves a micro-simulation of income,
taxes, and benefits by health condition and employment status based on
FRS data. To reproduce this analysis, the user also needs to install the
EUROMOD software and obtain the version of UKMOD used (B1.09) used for
the micro-simulation.

### R Packages

The analysis requires the use of a number of R packages for cleaning the
raw data for the FRS, LFS, USoc, and HSE. These packages are all open
source and available on GitHub:

- [`frsclean`](https://github.com/djmorris1989/frsclean)
- [`lfsclean`](https://github.com/STAPM/lfsclean)
- [`ukhlsclean`](https://github.com/STAPM/ukhlsclean)
- [`lfsclean`](https://github.com/STAPM/lfsclean)

Each of these packages are part of the `renv` environment and are
restored with the other CRAN packages when using `renv::restore()`.

## Citation

Please cite this code repository as:

Morris, D. Clarke, H. Brennan, A. and Whitworth, A. (2024) Estimating
costs and benefits of alternative IPS beyond SMI scenarios - code
repository. *University of Sheffield*. doi: .
