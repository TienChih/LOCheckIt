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
        
        InitialA = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],]
        InitialB = [0,0,0,0]
        InitialC = [0,0,0,0]
        InitialD = randrange(-20,3)

        
        
        
        for i in range(4):
            InitialB[i] = randrange(15,26)
            InitialC[i] = randrange(-5,0)
        
        positiverow = randrange(0,4)
        for i in range(4):
            for j in range(4):
                if i == positiverow:
                    InitialA[i][j] = choice([randrange(1,2), randrange(1,3)])
                else:
                    InitialA[i][j] = choice([randrange(-1,2), randrange(2,3)])
        
        
        pivotcolumns = [0,1,2,3]
        shuffle(pivotcolumns)
        pivotrows = []
        
        for j in range(3):
            pivcol = pivotcolumns[j]
            L=[]
            for i in range(4):
                if InitialA[i][pivcol] > 0:
                    L.append(Rational(InitialB[i]/InitialA[i][pivcol]))
            pivotvalue = min(L)
            for i in range(4):
                if InitialA[i][pivcol] > 0:
                    if  Rational(InitialB[i]/InitialA[i][pivcol]) == pivotvalue:
                        pivrow = i
            pivotrows.append(pivrow)            
            #print(pivrow)
            #print(pivcol)
            V = self.simplexpivot(InitialA,InitialB,InitialC,InitialD,pivrow,pivcol).copy()
            InitialA[0] = V[0][0].copy()
            InitialA[1] = V[0][1].copy()
            InitialA[2] = V[0][2].copy()
            InitialA[3] = V[0][3].copy()
            InitialB = V[1].copy()
            InitialC = V[2].copy()
            InitialD = V[3]
            #print(InitialA)
            #print(InitialB)
            #print(InitialC)
            #print(InitialD)
        scale = 1
        for i in range(4):
            for j in range(4):
                scale = lcm(InitialA[i][j].denominator(), scale)
        for i in range(4):
            InitialB[i] = InitialB[i]*scale
            InitialC[i] = InitialC[i]*scale
            for j in range(4):
                InitialA[i][j] = InitialA[i][j]*scale
        InitialD = InitialD*scale  
        
        
        
        
        VarName = ["x_1", "x_2", "x_3", "x_4", "t_1", "t_2", "t_3", "t_4",  ]
        TempVar = VarName.copy()


        NOA = [0,0,0,0]
        NOA[0] = InitialA[0].copy()
        NOA[1] = InitialA[1].copy()
        NOA[2] = InitialA[2].copy()
        NOA[3] = InitialA[3].copy()
        NOB = InitialB.copy()
        NOC = InitialC.copy()
        NOD = InitialD



        FinalA = [0,0,0,0]
        FinalA[0] = NOA[0].copy()
        FinalA[1] = NOA[1].copy()
        FinalA[2] = NOA[2].copy()
        FinalA[3] = NOA[3].copy()
        FinalB = NOB.copy()
        FinalC = NOC.copy()
        FinalD = NOD


        FinalA = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
        for i in range(4):
            for j in range(4):
                FinalA[i][j] = InitialA[i][j]
        FinalB = InitialB.copy()
        FinalC = InitialC.copy()
        FinalD = InitialD
        
        for i in range(3):
            V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivotrows[2-i],pivotcolumns[2-i]).copy()
            pivrow = pivotrows[2-i]
            pivcol = pivotcolumns[2-i]
            FinalA[0] = V[0][0].copy()
            FinalA[1] = V[0][1].copy()
            FinalA[2] = V[0][2].copy()
            FinalA[3] = V[0][3].copy()
            FinalB = V[1].copy()
            FinalC = V[2].copy()
            FinalD = V[3]
            for i in range(8):
                if i == pivcol:
                    TempVar[i] = VarName[4+pivrow]
                if i == pivrow + 4:
                    TempVar[i] = VarName[pivcol]    
                if i != pivcol and i != pivrow+4:
                    TempVar[i] = VarName[i]  
            VarName = TempVar.copy()        

        x1value = 0
        x2value = 0
        x3value = 0
        x4value = 0

        for i in range(4):
            if VarName[i+4] == "x_1":
                x1value = FinalB[i]
            if VarName[i+4] == "x_2":
                x2value = FinalB[i]
            if VarName[i+4] == "x_3":
                x3value = FinalB[i]        
            if VarName[i+4] == "x_4":
                x4value = FinalB[i]    

           

        

        
        
        
                                               

        return {
            "Fa11": FinalA[0][0],
            "Fa12": FinalA[0][1],
            "Fa13": FinalA[0][2],
            "Fa14": FinalA[0][3],
            "Fa21": FinalA[1][0],
            "Fa22": FinalA[1][1],
            "Fa23": FinalA[1][2],
            "Fa24": FinalA[1][3],
            "Fa31": FinalA[2][0],
            "Fa32": FinalA[2][1],
            "Fa33": FinalA[2][2],
            "Fa34": FinalA[2][3],
            "Fa41": FinalA[3][0],
            "Fa42": FinalA[3][1],
            "Fa43": FinalA[3][2],
            "Fa44": FinalA[3][3],
            "Fb1": FinalB[0],
            "Fb2": FinalB[1],
            "Fb3": FinalB[2],
            "Fb4": FinalB[3],
            "Fc1": FinalC[0],
            "Fc2": FinalC[1],
            "Fc3": FinalC[2],
            "Fc4": FinalC[3],
            "Fd": FinalD,
            "x1": VarName[0],
            "x2": VarName[1],
            "x3": VarName[2],
            "x4": VarName[3],
            "t1": VarName[4],
            "t2": VarName[5],
            "t3": VarName[6],
            "t4": VarName[7],
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
            "objectivefunction": NOC[0]*x_1 + NOC[1]*x_2 + NOC[2]*x_3 + NOC[3]*x_4 - NOD ,
            "row1": NOA[0][0]*x_1 + NOA[0][1]*x_2 + NOA[0][2]*x_3 + NOA[0][3]*x_4,
            "row2": NOA[1][0]*x_1 + NOA[1][1]*x_2 + NOA[1][2]*x_3 + NOA[1][3]*x_4,
            "row3": NOA[2][0]*x_1 + NOA[2][1]*x_2 + NOA[2][2]*x_3 + NOA[2][3]*x_4,
            "row4": NOA[3][0]*x_1 + NOA[3][1]*x_2 + NOA[3][2]*x_3 + NOA[3][3]*x_4,
            "x1value": x1value,
            "x2value": x2value,
            "x3value": x3value,
            "x4value": x4value,
            "optimalsolution": -1*FinalD
            
            
        }

    
    
