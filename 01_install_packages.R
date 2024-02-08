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