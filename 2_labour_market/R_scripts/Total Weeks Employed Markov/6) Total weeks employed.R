#construct a total weeks worked column 

totalweeksworked <- imputednasremoved 

totalweeksworked <- mutate(totalweeksworked, totalweeksworked = wave2months + wave3months + wave4months + wave5months)










