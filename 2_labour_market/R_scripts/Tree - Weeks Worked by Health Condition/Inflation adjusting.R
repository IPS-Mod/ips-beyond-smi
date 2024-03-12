data4 <- mutate(data4,
                inflatedwage = GRSSWK5 * 1.257742)

data5 <- mutate(data5,
                inflatedwage = GRSSWK5 * 1.249008)

data6 <- mutate(data6,
                inflatedwage = GRSSWK5 * 1.244071)

data7 <- mutate(data7,
                inflatedwage = GRSSWK5 * 1.235525)

data8 <- mutate(data8,
                inflatedwage = GRSSWK5 * 1.230694)

data9 <- mutate(data9,
                inflatedwage = GRSSWK5 * 1.217602)

data10 <- mutate(data10,
                inflatedwage = GRSSWK5 * 1.211742)

data11 <- mutate(data11,
                inflatedwage = GRSSWK5 * 1.202483)

data12 <- mutate(data12,
                inflatedwage = GRSSWK5 * 1.201336)

data13 <- mutate(data13,
                inflatedwage = GRSSWK5 * 1.189981)

data14 <- mutate(data14,
                inflatedwage = GRSSWK5 * 1.184384)

data15 <- mutate(data15,
                inflatedwage = GRSSWK5 * 1.177736)

data16 <- mutate(data16,
                inflatedwage = GRSSWK5 * 1.179944)

data17 <- mutate(data17,
                inflatedwage = GRSSWK5 * 1.167904)

data18 <- mutate(data18,
                inflatedwage = GRSSWK5 * 1.163586)

data19 <- mutate(data19,
                inflatedwage = GRSSWK5 * 1.161439)

data20 <- mutate(data20,
                inflatedwage = GRSSWK5 * 1.160369)

data21 <- mutate(data21,
                inflatedwage = GRSSWK5 * 1.158234)

data22 <- mutate(data22,
                inflatedwage = GRSSWK5 * 1.153987)

data23 <- mutate(data23,
                inflatedwage = GRSSWK5 * 1.151876)

data24 <- mutate(data24,
                inflatedwage = GRSSWK5 * 1.149772)

data25 <- mutate(data25,
                inflatedwage = GRSSWK5 * 1.135257)

data26 <- mutate(data26,
                inflatedwage = GRSSWK5 * 1.124107)

data27 <- mutate(data27,
                inflatedwage = GRSSWK5 * 1.103418)

data28 <- mutate(data28,
                inflatedwage = GRSSWK5 * 1.090043)

data29 <- mutate(data29,
                inflatedwage = GRSSWK5 * 1.051796)

data30 <- mutate(data30,
                inflatedwage = GRSSWK5 * 1.033662)

data31 <- mutate(data31,
                inflatedwage = GRSSWK5 * 1.008814)

data32 <- mutate(data32,
                inflatedwage = GRSSWK5 * 1)



datacomplete <- rbind(data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, 
                      data14, data15, data16, data17, data18, data19, data20, data21, data22, 
                      data23, data24, data25, data26, data27, data28, data29, data30, data31, data32, fill=TRUE)

