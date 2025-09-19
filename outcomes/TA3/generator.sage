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

        AL = [[0,0,0,0,0,], [0,0,0,0,0,],[0,0,0,0,0,],[0,0,0,0,0,],[0,0,0,0,0,],]

        for i in range(5):
            for j in range(5):
                AL[i][j] = randrange(1,10)

        A = matrix(AL)        

        OBJ = 0
        for i in range(5):
            for j in range(5):
                OBJ += -1*A[i][j]*x[i,j]

        P.set_objective(OBJ)

        

        for i in range(5):
            P.add_constraint(x[i,0]+x[i,1]+x[i,2]+x[i,3]+x[i,4] == 1)
        for j in range(5):
            P.add_constraint(x[0,j]+x[1,j]+x[2,j]+x[3,j]+x[4,j] == 1)   

        optimalsolution = -1*P.solve()
        
        C = 0
        data = []

        for i in range(5):
            for j in range(5):
                print(P.get_values(x[i,j]))
                if P.get_values(x[i,j]) > 0:
                    data.append({"Q":Rational(P.get_values(x[i,j])), "W": i+1, "M": j+1})


           
        
        
                                               

        return {
            "data": data,
            "optimalsolution": Rational(-1*P.solve()),
            "A": A,
            
            
        }

    
    
