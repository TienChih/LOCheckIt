class Generator(BaseGenerator):
    def simplexpivot(self,xA,xB,xC,xD,I,J):
        tempA = [[0,0,0,0],[0,0,0,0]]
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
        
        InitialA = [[0,0,0,0],[0,0,0,0]]
        InitialB = [0,0,0]
        InitialC = [0,0,0]
        InitialD = randrange(-20,3)

        
        dummy = 0
        while dummy == 0:
            InitialA[0][0] = randrange(1,6)
            InitialA[1][1] = randrange(1,6)
            InitialA[0][1] = randrange(1,6)
            InitialA[1][0] = randrange(1,6)
            M = matrix([[InitialA[0][0], InitialA[0][1]], [InitialA[1][0], InitialA[1][1]]])
            dummy = M.determinant()
        dummy=0

        InitialA[0][2] = randrange(1,6)
        InitialA[0][3] = randrange(-5,0)

        InitialA[1][3] = randrange(1,6)
        InitialA[1][2] = randrange(-5,0)    
                 
        
        


        InitialC = [randrange(1,6), randrange(1,6), randrange(1,6)*choice([-1,1]), randrange(1,6)*choice([-1,1]) ]

        InitialB = [randrange(10,21), randrange(10,21), ]
        shuffle(InitialC)
        
        

        ShuffleI = [0,1]
        shuffle(ShuffleI)
        ShuffleJ = [0,1,2,3]
        shuffle(ShuffleJ)   

        NOA = [0,0]
        NOA[0] = InitialA[0].copy()
        NOA[1] = InitialA[1].copy()
        NOB = InitialB.copy()
        NOC = InitialC.copy()
        NOD = InitialD

        for i in range(2):
            for j in range(4):    
                NOA[ShuffleI[i]][ShuffleJ[j]] = InitialA[i][j]

        for i in range(2):
            NOB[ShuffleI[i]] = InitialB[i]

        for j in range(4):
            NOC[ShuffleJ[j]] = InitialC[j]
            
            
            
        VarName = ["x_1", "x_2",  "x_3", "x_4", "t_1",  "t_2" ]
        TempVar = VarName.copy()

        FinalA = [0,0]
        FinalA[0] = NOA[0].copy()
        FinalA[1] = NOA[1].copy()
        FinalB = NOB.copy()
        FinalC = NOC.copy()
        FinalD = NOD


        

        pivrow = ShuffleI[1]
        pivcol = ShuffleJ[3]
        V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
        FinalA[0] = V[0][0].copy()
        FinalA[1] = V[0][1].copy()
        FinalB = V[1].copy()
        FinalC = V[2].copy()
        FinalD = V[3]
        for i in range(6):
            if i == pivcol:
                TempVar[i] = VarName[4+pivrow]
            if i == pivrow + 4:
                TempVar[i] = VarName[pivcol]    
            if i != pivcol and i != pivrow+4:
                TempVar[i] = VarName[i]  
        VarName = TempVar.copy()   


        pivrow = ShuffleI[0]
        pivcol = ShuffleJ[2]
        V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
        FinalA[0] = V[0][0].copy()
        FinalA[1] = V[0][1].copy()
        FinalB = V[1].copy()
        FinalC = V[2].copy()
        FinalD = V[3]
        for i in range(6):
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
        

        for i in range(2):
            if VarName[i+4] == "x_1":
                x1value = FinalB[i]
            if VarName[i+4] == "x_2":
                x2value = FinalB[i]
            if VarName[i+4] == "x_3":
                x3value = FinalB[i]
            if VarName[i+4] == "x_4":
                x4value = FinalB[i]    
             
                     
               

           

        

        
        
        

        return {
            "emptyregion": False,
            "Fa11": FinalA[0][min(ShuffleJ[0],ShuffleJ[1])],
            "Fa12": FinalA[0][max(ShuffleJ[0],ShuffleJ[1])],
            "Fa21": FinalA[1][min(ShuffleJ[0],ShuffleJ[1])],
            "Fa22": FinalA[1][max(ShuffleJ[0],ShuffleJ[1])],
            "Fb1": FinalB[0],
            "Fb2": FinalB[1],
            "Fc1": FinalC[min(ShuffleJ[0],ShuffleJ[1])],
            "Fc2": FinalC[max(ShuffleJ[0],ShuffleJ[1])],
            "Fd": FinalD,
            "x1": VarName[min(ShuffleJ[0],ShuffleJ[1])],
            "x2": VarName[max(ShuffleJ[0],ShuffleJ[1])],
            "t1": VarName[ShuffleI[0]+4],
            "t2": VarName[ShuffleI[1]+4],            
            # Initial
            "a11": NOA[0][0],
            "a12": NOA[0][1],
            "a13": NOA[0][2],
            "a14": NOA[0][3],
            "a21": NOA[1][0],
            "a22": NOA[1][1],
            "a23": NOA[1][2],
            "a24": NOA[1][3],
            "b1": NOB[0],
            "b2": NOB[1],
            "c1": NOC[0],
            "c2": NOC[1],
            "c3": NOC[2],
            "c4": NOC[3],
            "d": NOD,
            "objectivefunction": NOC[0]*x_1 + NOC[1]*x_2 +  NOC[2]*x_3 + NOC[3]*x_4   - NOD,
            "row1": NOA[0][0]*x_1 + NOA[0][1]*x_2 + NOA[0][2]*x_3 + NOA[0][3]*x_4,
            "row2": NOA[1][0]*x_1 + NOA[1][1]*x_2 + NOA[1][2]*x_3 + NOA[1][3]*x_4,
            "x1value": x1value,
            "x2value": x2value,
            "x3value": x3value,
            "x4value": x4value,
            "optimalsolution": -1*FinalD,
        }