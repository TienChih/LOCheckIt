class Generator(BaseGenerator):
    def simplexpivot(self,xA,xB,xC,xD,I,J):
        tempA = xB.copy()
        for i in range(len(xB)):
            tempA[i] = [0]*len(xC)
            for j in range(len(xC)):
                tempA[i][j] = Rational(xA[i][j])
        tempB = xB.copy()
        tempC = xC.copy()
        tempD = xD

        pivotvalue1 = xA[I][J]

        for i in range(len(xB)):
            for j in range(len(xC)):
                if i == I:
                    if j == J:
                        tempA[i][j] = Rational(1/pivotvalue1)
                    if j != J:
                        tempA[i][j] = Rational(xA[i][j]/pivotvalue1  )
                if j == J and i != I:
                    tempA[i][j] = Rational(-1*xA[i][j]/pivotvalue1  )
                if i != I and j != J:
                    tempA[i][j] = xA[i][j] - Rational(xA[i][J]*xA[I][j]/pivotvalue1  )

        for i in range(len(xB)):
            if i == I:
                tempB[i] = Rational(xB[i]/pivotvalue1)
            if i != I:
                tempB[i] = xB[i] - Rational(xA[i][J]*xB[I]/pivotvalue1  )
        for j in range(len(xC)):        
            if j == J:
                tempC[j] = Rational(-1*xC[j]/pivotvalue1)
            if j != J:
                tempC[j] = xC[j] - Rational(xC[J]*xA[I][j]/pivotvalue1)
        tempD = xD - Rational(xB[I]*xC[J]/pivotvalue1) 


        return([tempA, tempB, tempC, tempD])           
                

    def data(self):
        var('x_1 x_2 x_3 x_4')
        
        InitialA = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
        InitialB = [0,0,0,0]
        InitialC = [0,0,0,0]
        InitialD = 0


        dummy = 1
        while dummy != 0:
            dummy = 1
            PayoffInitial = [[0,0,0],[0,0,0],[0,0,0],]
            saddleI = randrange(0,3)
            saddleJ = randrange(0,3)
            while dummy != 0:
                dummy = 0
                PayoffInitial[saddleI][saddleJ] = randrange(-5,6)
                for k in range(3):
                    if k != saddleI:
                        PayoffInitial[k][saddleJ] = PayoffInitial[saddleI][saddleJ] - choice([randrange(0,3),0])
                        dummy += PayoffInitial[k][saddleJ]
                    if k != saddleJ:
                        PayoffInitial[saddleI][k] = PayoffInitial[saddleI][saddleJ] + choice([randrange(0,3),0])
                        dummy += PayoffInitial[saddleI][k]    

                for i in range(3):
                    for j in range(3):
                        if i != saddleI and j != saddleJ:
                            PayoffInitial[i][j] = randrange(1,6)*choice([-1,1])
                            dummy += PayoffInitial[i][j]
            
            for i in range(3):
                for ip in range(3):
                    if i != ip:
                        if PayoffInitial[i][0] >= PayoffInitial[ip][0] and PayoffInitial[i][1] >= PayoffInitial[ip][1] and PayoffInitial[i][2] >= PayoffInitial[ip][2]:
                            dummy = 1
                        if PayoffInitial[0][i] >= PayoffInitial[0][ip] and PayoffInitial[1][i] >= PayoffInitial[1][ip] and PayoffInitial[2][i] >= PayoffInitial[2][ip]:
                            dummy = 1    
                            
                            
        Payoff = [[0,0,0],[0,0,0],[0,0,0],]
        for i in range(3):
            Payoff[i] = PayoffInitial[i].copy()
        OrI = [0,1,2]
        OrJ = [0,1,2]

        for k in range(8):
            addition = choice(["row", "col"])
            if addition == "row":
                V = randrange(0, len(Payoff)+1)
                C = randrange(0, len(Payoff))

                adjustment = [0]*len(Payoff[0])
                adjustment[0] = -1
                for i in range(len(Payoff[0])-1):
                    adjustment[i+1] = choice([randrange(-2,1),0,0])
                NewPayoff = [0]*(len(Payoff)+1)
                for i in range(len(Payoff)+1):     
                    if i < V:
                        NewPayoff[i] = Payoff[i].copy()
                    if i == V:
                        NewPayoff[i] = Payoff[0].copy()
                        for j in range(len(Payoff[0])):
                            NewPayoff[i][j] =  Payoff[C][j]+adjustment[j]  
                    if i > V:
                        NewPayoff[i] = Payoff[i-1].copy() 
                Payoff = [0]*(len(NewPayoff))
                for i in range(len(Payoff)):
                    Payoff[i] = NewPayoff[i].copy()
                if V <= OrI[0]:
                    OrI[0] += 1    
                    OrI[1] += 1    
                    OrI[2] += 1
                elif V > OrI[0] and V <= OrI[1]:
                    OrI[1] += 1    
                    OrI[2] += 1
                elif V > OrI[1] and V <= OrI[2]:
                    OrI[2] += 1    


            if addition == "col":
                V = randrange(0, len(Payoff[0])+1)
                C = randrange(0, len(Payoff[0]))

                adjustment = [0]*len(Payoff)
                adjustment[0] = 1
                for i in range(len(Payoff)-1):
                    adjustment[i+1] = choice([randrange(0,3),0,0])
                NewPayoff = [0]*(len(Payoff))
                for i in range(len(Payoff)):
                    NewPayoff[i]=([0]*(len(Payoff[0])+1)).copy()
                    for j in range(len(Payoff[0])+1):     
                        if j < V:
                            NewPayoff[i][j] = Payoff[i][j]
                        if j == V:
                            NewPayoff[i][j] = Payoff[i][C]+adjustment[i]
                    
                        if j > V:
                            NewPayoff[i][j] = Payoff[i][j-1] 
                Payoff = [0]*(len(NewPayoff))
                for i in range(len(Payoff)):
                    Payoff[i] = NewPayoff[i].copy() 

                if V <= OrJ[0]:
                    OrJ[0] += 1    
                    OrJ[1] += 1    
                    OrJ[2] += 1
                elif V > OrI[0] and V <= OrI[1]:
                    OrJ[1] += 1    
                    OrJ[2] += 1
                elif V > OrI[1] and V <= OrI[2]:
                    OrJ[2] += 1       

         
            
             
                     
        if PayoffInitial[saddleI][saddleJ] == 0:
            conclusion = "is a fair game"
        if PayoffInitial[saddleI][saddleJ] < 0:
            conclusion = "favors the column player"
        if PayoffInitial[saddleI][saddleJ] > 0:
            conclusion = "favors the row player"                

           

        

        
        
        OI = [0,1,2]
        OJ = [0,1,2]

        return {
            "payoff": matrix(Payoff),
            "domination": matrix(PayoffInitial),
            "r1strat": OrI[0]+1,
            "r2strat": OrI[1]+1,
            "r3strat": OrI[2]+1,
            "c1strat": OrJ[0]+1,
            "c2strat": OrJ[1]+1,
            "c3strat": OrJ[2]+1,
            "optimalsolution": PayoffInitial[saddleI][saddleJ],
            "ropt": OrI[saddleI]+1,
            "copt": OrJ[saddleJ]+1,
            "conclusion": conclusion,
        }