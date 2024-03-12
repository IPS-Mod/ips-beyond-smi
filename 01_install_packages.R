##### INSTALL fingertipsR

# Enable repository from ropensci
options(repos = c(
  ropensci = 'https://ropensci.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))

# Download and install fingertipsR in R
install.packages('fingertipsR')

##### INSTALL frsclean

devtools::install_git(
  "https://github.com/djmorris1989/frsclean.git", 
  ref = "1.0.2",
  build_vignettes = TRUE
)

### Install hseclean from the STAPM github 

devtools::install_git(
  "https://github.com/STAPM/hseclean.git",
  ref = "1.11.4",
  build_vignettes = FALSE)

### Install ukhlsclean from the STAPM github 

devtools::install_git(
  "https://github.com/STAPM/ukhlsclean.git",
  ref = "1.0.1",
  build_vignettes = FALSE)

### Install lfsclean from the STAPM github 

devtools::install_git(
  "https://github.com/STAPM/lfsclean.git",
  ref = "1.1.2",
  build_vignettes = FALSE)