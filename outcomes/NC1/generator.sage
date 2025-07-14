class Generator(BaseGenerator):
    def simplexpivot(self,xA,xB,xC,xD,I,J):
        tempA = [[0,0],[0,0],[0,0],[0,0]]
        for i in range(len(xB)):
            for j in range(len(xC)):
                tempA[i][j] = xA[i][j]
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
        
        InitialA = [[0,0],[0,0],[0,0],[0,0],]
        InitialB = [0,0,0]
        InitialC = [0,0,0]
        InitialD = randrange(-20,3)

        
        dummy = 0
        while dummy == 0:
            InitialA[0][0] = randrange(-5,0)
            InitialA[1][1] = randrange(1,6)
            InitialA[0][1] = randrange(1,6)
            InitialA[1][0] = randrange(1,6)
            M = matrix([InitialA[0], InitialA[1]])
            dummy = M.determinant()
        dummy=0    
        while dummy == 0:
            InitialA[2][0] = randrange(1,6)
            InitialA[3][1] = randrange(-5,0)
            InitialA[2][1] = randrange(-5,0)
            InitialA[3][0] = randrange(-5,0)
            M = matrix([InitialA[2], InitialA[3]])
            dummy = M.determinant()            
        
        


        InitialC = [randrange(1,6), randrange(1,6)*choice([-1,1])]
        shuffle(InitialC)

        InitialB = [randrange(10,21), randrange(10,21), randrange(10,21), randrange(10,21), ]
        shuffle(InitialB)
        
        

        ShuffleI = [0,1,2,3]
        shuffle(ShuffleI)
        ShuffleJ = [0,1]
        shuffle(ShuffleJ)   

        NOA = [0,0,0,0]
        NOA[0] = InitialA[0].copy()
        NOA[1] = InitialA[1].copy()
        NOA[2] = InitialA[2].copy()
        NOA[3] = InitialA[3].copy()
        NOB = InitialB.copy()
        NOC = InitialC.copy()
        NOD = InitialD

        for i in range(4):
            for j in range(2):    
                NOA[ShuffleI[i]][ShuffleJ[j]] = InitialA[i][j]

        for i in range(4):
            NOB[ShuffleI[i]] = InitialB[i]

        for j in range(2):
            NOC[ShuffleJ[j]] = InitialC[j]
            
            
            
        VarName = ["x_1", "x_2",  "t_1", "t_2", "t_3",  "t_4" ]
        TempVar = VarName.copy()

        FinalA = [0,0,0,0]
        FinalA[0] = NOA[0].copy()
        FinalA[1] = NOA[1].copy()
        FinalA[2] = NOA[2].copy()
        FinalA[3] = NOA[3].copy()
        FinalB = NOB.copy()
        FinalC = NOC.copy()
        FinalD = NOD


        

        pivrow = ShuffleI[2]
        pivcol = ShuffleJ[0]
        V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
        FinalA[0] = V[0][0].copy()
        FinalA[1] = V[0][1].copy()
        FinalA[2] = V[0][2].copy()
        FinalA[3] = V[0][3].copy()
        FinalB = V[1].copy()
        FinalC = V[2].copy()
        FinalD = V[3]
        for i in range(6):
            if i == pivcol:
                TempVar[i] = VarName[2+pivrow]
            if i == pivrow + 2:
                TempVar[i] = VarName[pivcol]    
            if i != pivcol and i != pivrow+2:
                TempVar[i] = VarName[i]  
        VarName = TempVar.copy()   


        pivrow = ShuffleI[3]
        pivcol = ShuffleJ[1]
        V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
        FinalA[0] = V[0][0].copy()
        FinalA[1] = V[0][1].copy()
        FinalA[2] = V[0][2].copy()
        FinalA[3] = V[0][3].copy()
        FinalB = V[1].copy()
        FinalC = V[2].copy()
        FinalD = V[3]
        for i in range(6):
            if i == pivcol:
                TempVar[i] = VarName[2+pivrow]
            if i == pivrow + 2:
                TempVar[i] = VarName[pivcol]    
            if i != pivcol and i != pivrow+2:
                TempVar[i] = VarName[i]  
        VarName = TempVar.copy()   

        

        x1value = 0
        x2value = 0
        

        for i in range(4):
            if VarName[i+2] == "x_1":
                x1value = FinalB[i]
            if VarName[i+2] == "x_2":
                x2value = FinalB[i]
             
                     
               

           

        

        
        
        

        return {
            "emptyregion": False,
            "Fa11": FinalA[min(ShuffleI[0],ShuffleI[1]) ][0],
            "Fa12": FinalA[min(ShuffleI[0],ShuffleI[1])][1],
            "Fa21": FinalA[max(ShuffleI[0],ShuffleI[1])][0],
            "Fa22": FinalA[max(ShuffleI[0],ShuffleI[1])][1],
            "Fb1": FinalB[min(ShuffleI[0],ShuffleI[1])],
            "Fb2": FinalB[max(ShuffleI[0],ShuffleI[1])],
            "Fc1": FinalC[0],
            "Fc2": FinalC[1],
            "Fd": FinalD,
            "x1": VarName[0],
            "x2": VarName[1],
            "t1": VarName[min(ShuffleI[0],ShuffleI[1])+2],
            "t2": VarName[max(ShuffleI[0],ShuffleI[1])+2],            
            # Initial
            "a11": NOA[0][0],
            "a12": NOA[0][1],
            "a21": NOA[1][0],
            "a22": NOA[1][1],
            "a31": NOA[2][0],
            "a32": NOA[2][1],
            "a41": NOA[3][0],
            "a42": NOA[3][1],
            "b1": NOB[0],
            "b2": NOB[1],
            "b3": NOB[2],
            "b4": NOB[3],
            "c1": NOC[0],
            "c2": NOC[1],
            "d": NOD,
            "objectivefunction": NOC[0]*x_1 + NOC[1]*x_2   - NOD,
            "row1": NOA[0][0]*x_1 + NOA[0][1]*x_2,
            "row2": NOA[1][0]*x_1 + NOA[1][1]*x_2,
            "row3": NOA[2][0]*x_1 + NOA[2][1]*x_2,
            "row4": NOA[3][0]*x_1 + NOA[3][1]*x_2,
            "x1value": x1value,
            "x2value": x2value,
            "optimalsolution": -1*FinalD,
        }