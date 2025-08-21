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
            while dummy != 0:
                dummy = 0
                for i in range(3):
                    for j in range(3):
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

        for k in range(4):
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

        NOA = [[Rational(0),Rational(-1),Rational(-1),Rational(-1)],
        [Rational(-1), Rational(PayoffInitial[0][0]), Rational(PayoffInitial[0][1]) , Rational(PayoffInitial[0][2])], 
        [Rational(-1), Rational(PayoffInitial[1][0]), Rational(PayoffInitial[1][1]) , Rational(PayoffInitial[1][2])], 
        [Rational(-1), Rational(PayoffInitial[2][0]), Rational(PayoffInitial[2][1]) , Rational(PayoffInitial[2][2])], ]   

        NOB = [-1,0,0,0]
        NOC = [-1,0,0,0]
        NOD = 0

        ShuffleI = [0,1,2,3]
        ShuffleJ = [0,1,2,3]
        pivrow = ShuffleI[0]
        pivcol = ShuffleJ[1]
        V = self.simplexpivot(NOA,NOB,NOC,NOD,pivrow,pivcol).copy()
        WorseA = [0]*len(NOA)
        for i in range(len(NOA)):
            WorseA[i]=V[0][i].copy()
        WorseB = V[1].copy()
        WorseC = V[2].copy()
        WorseD = V[3]

        pivrow = ShuffleI[1]
        pivcol = ShuffleJ[0]
        V = self.simplexpivot(WorseA,WorseB,WorseC,WorseD,pivrow,pivcol).copy()
        WorseA = [0]*len(NOA)
        for i in range(len(NOA)):
            WorseA[i]=V[0][i].copy()
        WorseB = V[1].copy()
        WorseC = V[2].copy()
        WorseD = V[3]
        
            
            
            
        VarName = ["t_1", "q_2",  "q_3", "q_1",  "t_2" , "t_3",  ]
        TempVar = VarName.copy()

        VarNameD = ["s_1", "p_2",  "p_3", "p_1",  "s_2" , "s_3",  ]
        TempVarD = VarNameD.copy()

        FinalA = [[WorseA[0][0], WorseA[0][2], WorseA[0][3], ],
        [WorseA[2][0], WorseA[2][2], WorseA[2][3], ], 
        [WorseA[3][0], WorseA[3][2], WorseA[3][3], ],
        ]
        FinalB = [WorseB[0], WorseB[2], WorseB[3]]
        FinalC = [WorseC[0], WorseC[2], WorseC[3]]
        FinalD = WorseD

        ShuffleI = [0,1,2]
        ShuffleJ = [0,1,2]

        while min(FinalB) < 0:
            for i in range(len(FinalB)):
                if FinalB[i]<0:
                    K = i
                    pivrow = i
            for j in range(len(FinalC)):
                if FinalA[K][j] < 0:
                    pivcol = j
            for i in range(len(FinalB)):
                if FinalA[i][pivcol]>0:
                    if i > K and FinalB[i]/FinalA[i][pivcol]<FinalB[K]/FinalA[K][pivcol]:
                        pivrow = i 
                        K = i 
            V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
            FinalA[0] = V[0][0].copy()
            FinalA[1] = V[0][1].copy()
            FinalA[2] = V[0][2].copy()
            FinalB = V[1].copy()
            FinalC = V[2].copy()
            FinalD = V[3]
            for i in range(6):
                if i == pivcol:
                    TempVar[i] = VarName[3+pivrow]
                if i == pivrow + 3:
                    TempVar[i] = VarName[pivcol] 
                if i != pivcol and i != pivrow+3:
                    TempVar[i] = VarName[i]  

                if i == pivrow:
                    TempVarD[i] = VarNameD[3+pivcol]
                if i == pivcol + 3:
                    TempVarD[i] = VarNameD[pivrow] 
                if i != pivrow and i != pivcol+3:
                    TempVarD[i] = VarNameD[i]          
                     
                       
                 
            VarName = TempVar.copy()
            VarNameD = TempVarD.copy()

        while max(FinalC) > 0:
            for j in range(len(FinalC)):
                if FinalC[j]>0:
                    K = j
                    pivcol = j
            for i in range(len(FinalB)):
                if FinalA[i][K] > 0:
                    pivrow = i
            for i in range(len(FinalB)):
                if FinalA[i][pivcol] > 0:
                    if FinalB[i]/FinalA[i][pivcol] < FinalB[pivrow]/FinalA[pivrow][pivcol]:
                        pivrow = i 
            V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
            FinalA[0] = V[0][0].copy()
            FinalA[1] = V[0][1].copy()
            FinalA[2] = V[0][2].copy()
            FinalB = V[1].copy()
            FinalC = V[2].copy()
            FinalD = V[3]
            for i in range(6):
                if i == pivcol:
                    TempVar[i] = VarName[3+pivrow]
                if i == pivrow + 3:
                    TempVar[i] = VarName[pivcol]
                       
                if i != pivcol and i != pivrow+3:
                    TempVar[i] = VarName[i]  

                if i == pivrow:
                    TempVarD[i] = VarNameD[3+pivcol]
                if i == pivcol + 3:
                    TempVarD[i] = VarNameD[pivrow] 
                if i != pivrow and i != pivcol+3:
                    TempVar[i] = VarName[i]  
            VarName = TempVar.copy()
            VarNameD = TempVarD.copy()


        

        

        

        x1value = 0
        x2value = 0
        x3value = 0
        y1value = 0
        y2value = 0
        y3value = 0
        

        for i in range(3):
            if VarName[i+3] == "q_1":
                x1value = FinalB[i]
            if VarName[i+3] == "q_2":
                x2value = FinalB[i]
            if VarName[i+3] == "q_3":
                x3value = FinalB[i]
            if VarNameD[i+3] == "p_1":
                y1value = -1*FinalC[i]
            if VarNameD[i+3] == "p_2":
                y2value = -1*FinalC[i]
            if VarNameD[i+3] == "p_3":
                y3value = -1*FinalC[i]    
            
             
                     
        if -1*FinalD == 0:
            conclusion = "is a fair game"
        if -1*FinalD < 0:
            conclusion = "favors the column player"
        if -1*FinalD > 0:
            conclusion = "favors the row player"                

           

        

        
        
        OI = [0,1,2]
        OJ = [0,1,2]

        return {
            "payoff": matrix(Payoff),
            "domination": matrix(PayoffInitial),
            "Fa11": FinalA[OI[0]][OJ[0]],
            "Fa12": FinalA[OJ[0]][OJ[1]],
            "Fa13": FinalA[OJ[0]][OJ[2]],
            "Fa21": FinalA[OJ[1]][OJ[0]],
            "Fa22": FinalA[OJ[1]][OJ[1]],
            "Fa23": FinalA[OJ[1]][OJ[2]],
            "Fa31": FinalA[OJ[2]][OJ[0]],
            "Fa32": FinalA[OJ[2]][OJ[1]],
            "Fa33": FinalA[OJ[2]][OJ[2]],
            "Fb1": FinalB[OI[0]],
            "Fb2": FinalB[OI[1]],
            "Fb3": FinalB[OI[2]],
            "Fc1": FinalC[OJ[0]],
            "Fc2": FinalC[OJ[1]],
            "Fc3": FinalC[OJ[2]],
            "Fd": FinalD,
            "x1": VarName[OJ[0]],
            "x2": VarName[OJ[1]],
            "x3": VarName[OJ[2]],
            #"x4": VarName[3],
            "t1": VarName[3+OI[0]],
            "t2": VarName[3+OI[1]],
            "t3": VarName[3+OI[2]],
            #"t4": VarName[7],
            "y1": VarNameD[OI[0]],
            "y2": VarNameD[OI[1]],
            "y3": VarNameD[OI[2]],
            #"x4": VarName[3],
            "s1": VarNameD[3+OJ[0]],
            "s2": VarNameD[3+OJ[1]],
            "s3": VarNameD[3+OJ[2]],
            # Initial
            "a11": NOA[0][0],
            "a12": NOA[0][1],
            "a13": NOA[0][2],
            "a14": NOA[0][3],
            "a21": NOA[1][0],
            "a22": NOA[1][1],
            "a23": NOA[1][2],
            "a24": NOA[1][3],
            "a31": NOA[2][0],
            "a32": NOA[2][1],
            "a33": NOA[2][2],
            "a34": NOA[2][3],
            "a41": NOA[3][0],
            "a42": NOA[3][1],
            "a43": NOA[3][2],
            "a44": NOA[3][3],
            "b1": NOB[0],
            "b2": NOB[1],
            "b3": NOB[2],
            "b4": NOB[3],
            "c1": NOC[0],
            "c2": NOC[1],
            "c3": NOC[2],
            "c4": NOC[3],
            "d": NOD,
            "x1value": x1value,
            "x2value": x2value,
            "x3value": x3value,
            "y1value": y1value,
            "y2value": y2value,
            "y3value": y3value,
            "r1strat": OrI[0]+1,
            "r2strat": OrI[1]+1,
            "r3strat": OrI[2]+1,
            "c1strat": OrJ[0]+1,
            "c2strat": OrJ[1]+1,
            "c3strat": OrJ[2]+1,
            "optimalsolution": -1*FinalD,
            "conclusion": conclusion,
        }