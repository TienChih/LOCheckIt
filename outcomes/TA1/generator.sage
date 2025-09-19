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

        A = matrix([[randrange(1,10),randrange(1,10),randrange(1,10),randrange(1,10)],
            [randrange(1,10),randrange(1,10),randrange(1,10),randrange(1,10)],
            [randrange(1,10),randrange(1,10),randrange(1,10),randrange(1,10)],
            [randrange(1,10),randrange(1,10),randrange(1,10),randrange(1,10)],] )

        OBJ = 0
        for i in range(4):
            for j in range(4):
                OBJ += -1*A[i][j]*x[i,j]

        P.set_objective(OBJ)

        n = randrange(20,41)

        parts = Partitions(n, length=4, min_part=4).list()
        shuffle(parts)
        

        W = [parts[0][0]*5, parts[0][1]*5, parts[0][2]*5, parts[0][3]*5, ]
        M = [parts[1][0]*5, parts[1][1]*5, parts[1][2]*5, parts[1][3]*5, ]

        shuffle(W)
        shuffle(M)

        for i in range(4):
            P.add_constraint(x[i,0]+x[i,1]+x[i,2]+x[i,3] == W[i])
        for j in range(4):
            P.add_constraint(x[0,j]+x[1,j]+x[2,j]+x[3,j] == M[j])   

        optimalsolution = -1*P.solve()
        
        ShipW = [0,0,0,0,0,0,0]
        ShipM = [0,0,0,0,0,0,0] 
        ShipQ = [0,0,0,0,0,0,0] 

        C = 0
        data = []

        for i in range(4):
            for j in range(4):
                print(P.get_values(x[i,j]))
                if P.get_values(x[i,j]) > 0:
                    data.append({"Q":Rational(P.get_values(x[i,j])), "W": i+1, "M": j+1})


           
        
        fictional_products = [
            "StarBlade",
            "ManaCore",
            "WarpStone",
            "DragonScale",
            "VoidAmulet",
            "ChronoRing",
            "PlasmaWand",
            "ShadowOrb",
            "NeuroStaff",
            "PhoenixChip",
            "EtherBoot",
            "CryoRune",
            "NanoGrimoire",
            "StormCrystal",
            "PsiBlade",
            "LunarForge",
            "ArcaneDrive",
            "QuantumCharm",
            "MythicCircuit",
            "AstralKey"
        ]
            
        

        
        
        
                                               

        return {
            # Initial
            "a11": A[0][0],
            "a12": A[0][1],
            "a13": A[0][2],
            "a14": A[0][3],
            "a21": A[1][0],
            "a22": A[1][1],
            "a23": A[1][2],
            "a24": A[1][3],
            "a31": A[2][0],
            "a32": A[2][1],
            "a33": A[2][2],
            "a34": A[2][3],
            "a41": A[3][0],
            "a42": A[3][1],
            "a43": A[3][2],
            "a44": A[3][3],
            "W1": W[0],
            "W2": W[1],
            "W3": W[2],
            "W4": W[3],
            "M1": M[0],
            "M2": M[1],
            "M3": M[2],
            "M4": M[3],
            "data": data,
            "optimalsolution": Rational(-1*P.solve()),
            "A": A,
            "total": 5*n,
            "good": choice(fictional_products),
            
            
            
        }

    
    
