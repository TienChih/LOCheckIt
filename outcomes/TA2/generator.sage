class Generator(BaseGenerator):
    def simplexpivot(self,xA,xB,xC,xD,I,J):
        tempA = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
        for i in range(4):
            for j in range(4):
                tempA[i][j] = xA[i][j]
        tempB = xB.copy()
        tempC = xC.copy()
        tempD = xD

        pivotvalue1 = xA[I][J]

        for i in range(4):
            for j in range(4):
                if i == I:
                    if j == J:
                        tempA[i][j] = Rational(1/pivotvalue1)
                    if j != J:
                        tempA[i][j] = Rational(xA[i][j]/pivotvalue1  )
                if j == J and i != I:
                    tempA[i][j] = Rational(-1*xA[i][j]/pivotvalue1  )
                if i != I and j != J:
                    tempA[i][j] = xA[i][j] - Rational(xA[i][J]*xA[I][j]/pivotvalue1  )

        for i in range(4):
            if i == I:
                tempB[i] = Rational(xB[i]/pivotvalue1)
            if i != I:
                tempB[i] = xB[i] - Rational(xA[i][J]*xB[I]/pivotvalue1  )
            if i == J:
                tempC[i] = Rational(-1*xC[i]/pivotvalue1)
            if i != J:
                tempC[i] = xC[i] - Rational(xC[J]*xA[I][i]/pivotvalue1)
        tempD = xD - Rational(xB[I]*xC[J]/pivotvalue1) 


        return([tempA, tempB, tempC, tempD])           
                

    def data(self):
        var('x_1 x_2 x_3 x_4')
        
        P = MixedIntegerLinearProgram()
        x = P.new_variable(integer=True, nonnegative=True)

        slowcost = 5*randrange(4,11)
        fastcost = slowcost + randrange(2,6)*5
        newcost = fastcost + 5*randrange(4,11)

        A = [[newcost,newcost,newcost,newcost],
            [1000000,fastcost,slowcost,slowcost],
            [1000000,1000000,fastcost,slowcost],
            [1000000,1000000,1000000,fastcost],] 

        OBJ = 0
        for i in range(4):
            for j in range(4):
                OBJ += -1*A[i][j]*x[i,j]

        P.set_objective(OBJ)

        n = randrange(20,41)

        parts = Partitions(n, length=4, min_part=4).list()
        shuffle(parts)
        

        M = [parts[1][0]*5, parts[1][1]*5, parts[1][2]*5, parts[1][3]*5, ]
        shuffle(M)

        W = [sum(M), M[0], M[1], M[2]]

        for i in range(4):
            P.add_constraint(x[i,0]+x[i,1]+x[i,2]+x[i,3] <= W[i])
        for j in range(4):
            P.add_constraint(x[0,j]+x[1,j]+x[2,j]+x[3,j] == M[j])   

        optimalsolution = -1*P.solve()
        
        ShipW = [0,0,0,0,0,0,0]
        ShipM = [0,0,0,0,0,0,0] 
        ShipQ = [0,0,0,0,0,0,0] 



           
        
        fictional_products = [
            "StarPod",
            "GravBike",
            "SkyRider",
            "WarpCar",
            "IonGlider",
            "NebulaCab",
            "PulseBoard",
            "AstroCruiser",
            "VoidRunner",
            "LumeCycle",
            "HyperYacht",
            "QuantumCab",
            "PlasmaSkiff",
            "OrbitShuttle",
            "FluxPod",
            "SolarSled",
            "CryoCruiser",
            "ZenithJet",
            "NanoRider",
            "EclipseCar"
        ]

            
        

        
        
        
                                               

        return {
            # Initial
            "M1": M[0],
            "M2": M[1],
            "M3": M[2],
            "M4": M[3],
            "optimalsolution": Rational(-1*P.solve()),
            "good": choice(fictional_products),
            "newcost": newcost,
            "fastcost": fastcost,
            "slowcost": slowcost,
            "purchase": Rational(P.get_values(x[0,0]) + P.get_values(x[0,1]) + P.get_values(x[0,2]) + P.get_values(x[0,3])),
            "day1fast": Rational(P.get_values(x[1,1])),
            "day1slow": Rational(P.get_values(x[1,2]) + P.get_values(x[1,3])),
            "day2fast": Rational(P.get_values(x[2,2])),
            "day2slow": Rational(P.get_values(x[2,3])),
            "day3fast": Rational(P.get_values(x[3,3])),
            
            
            
        }

    
    
