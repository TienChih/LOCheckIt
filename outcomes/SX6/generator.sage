class Generator(BaseGenerator):
    def simplexpivot(self,xA,xB,xC,xD,I,J):
        tempA = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
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
        
        InitialA = [[0,0,0],[0,0,0],[0,0,0],]
        InitialB = [0,0,0]
        InitialC = [0,0,0]
        InitialD = randrange(-20,3)

        L = [5,1,2,3,4,6]
        shuffle(L)
        M = [L[0], L[1], L[2]]
        M.sort()
        point1x = M[0]
        point2x = M[1]
        point3x = M[2]

        L = [1,2,3,4,6]
        shuffle(L)
        M = [L[0], L[1], L[2]]
        M.sort()
        point1y = M[1]
        point2y = M[0]
        point3y = M[2]

        L = [5,1,2,3,4,6]
        shuffle(L)
        M = [L[0], L[1], L[2]]
        M.sort()
        point1z = M[0]
        point2z = M[1]
        point3z = M[2]

        InitialB[1] = -1*lcm([point1x, point1y, point1z])
        InitialA[1][0] = InitialB[1]/point1x
        InitialA[1][1] = InitialB[1]/point1y
        InitialA[1][2] = InitialB[1]/point1z

        InitialB[2] = -1*lcm([point2x, point2y, point2z])
        InitialA[2][0] = InitialB[2]/point2x
        InitialA[2][1] = InitialB[2]/point2y
        InitialA[2][2] = InitialB[2]/point2z

        InitialB[0] = lcm([point3x, point3y, point3z])
        InitialA[0][0] = InitialB[0]/point3x
        InitialA[0][1] = InitialB[0]/point3y
        InitialA[0][2] = InitialB[0]/point3z


        InitialC = [randrange(1,6), randrange(1,6), randrange(-5,6), ]
        shuffle(InitialC)
        
        

        ShuffleI = [0,1,2]
        #shuffle(ShuffleI)
        ShuffleJ = [0,1,2]
        shuffle(ShuffleJ)   

        NOA = [0,0,0,0]
        NOA[0] = InitialA[0].copy()
        NOA[1] = InitialA[1].copy()
        NOA[2] = InitialA[2].copy()
        NOB = InitialB.copy()
        NOC = InitialC.copy()
        NOD = InitialD

        for i in range(3):
            for j in range(3):    
                NOA[ShuffleI[i]][ShuffleJ[j]] = InitialA[i][j]

        for i in range(3):
            NOB[ShuffleI[i]] = InitialB[i]

        for j in range(3):
            NOC[ShuffleJ[j]] = InitialC[j]
            
            
            
        VarName = ["x_1", "x_2", "x_3",  "t_1", "t_2", "t_3",   ]
        TempVar = VarName.copy()

        FinalA = [0,0,0,0]
        FinalA[0] = NOA[0].copy()
        FinalA[1] = NOA[1].copy()
        FinalA[2] = NOA[2].copy()
        FinalB = NOB.copy()
        FinalC = NOC.copy()
        FinalD = NOD


        

        pivrow = ShuffleI[2]
        pivcol = ShuffleJ[1]
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
        VarName = TempVar.copy()   


        pivrow = ShuffleI[1]
        pivcol = ShuffleJ[0]
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
        VarName = TempVar.copy()   

        

        x1value = 0
        x2value = 0
        x3value = 0
        x4value = 0

        for i in range(3):
            if VarName[i+3] == "x_1":
                x1value = FinalB[i]
            if VarName[i+3] == "x_2":
                x2value = FinalB[i]
            if VarName[i+3] == "x_3":
                x3value = FinalB[i]  
                     
               

           

        

        
        
        

        tasks=[ {
            "emptyregion": False,
            "Fa11": FinalA[0][0],
            "Fa12": FinalA[0][1],
            "Fa13": FinalA[0][2],
            "Fa21": FinalA[1][0],
            "Fa22": FinalA[1][1],
            "Fa23": FinalA[1][2],
            "Fa31": FinalA[2][0],
            "Fa32": FinalA[2][1],
            "Fa33": FinalA[2][2],
            "Fb1": FinalB[0],
            "Fb2": FinalB[1],
            "Fb3": FinalB[2],
            "Fc1": FinalC[0],
            "Fc2": FinalC[1],
            "Fc3": FinalC[2],
            "Fd": FinalD,
            "x1": VarName[0],
            "x2": VarName[1],
            "x3": VarName[2],
            "t1": VarName[3],
            "t2": VarName[4],
            "t3": VarName[5],
            # Initial
            "a11": NOA[0][0],
            "a12": NOA[0][1],
            "a13": NOA[0][2],
            "a21": NOA[1][0],
            "a22": NOA[1][1],
            "a23": NOA[1][2],
            "a31": NOA[2][0],
            "a32": NOA[2][1],
            "a33": NOA[2][2],
            "b1": NOB[0],
            "b2": NOB[1],
            "b3": NOB[2],
            "c1": NOC[0],
            "c2": NOC[1],
            "c3": NOC[2],
            "d": NOD,
            "objectivefunction": NOC[0]*x_1 + NOC[1]*x_2 + NOC[2]*x_3  - NOD,
            "row1": NOA[0][0]*x_1 + NOA[0][1]*x_2 + NOA[0][2]*x_3 ,
            "row2": NOA[1][0]*x_1 + NOA[1][1]*x_2 + NOA[1][2]*x_3,
            "row3": NOA[2][0]*x_1 + NOA[2][1]*x_2 + NOA[2][2]*x_3,
            "x1value": x1value,
            "x2value": x2value,
            "x3value": x3value,
            "optimalsolution": -1*FinalD,
        }]























        InitialA = [[0,0,0],[0,0,0],[0,0,0],]
        InitialB = [0,0,0]
        InitialC = [0,0,0]
        InitialD = randrange(-20,3)

        dummy = -1

        while dummy<= 0:
            InitialA[1][1] = randrange(-2,0)
            InitialA[2][2] = randrange(-2,0)
            InitialA[1][2] = randrange(1,3)
            InitialA[2][1] = randrange(1,3)
            dummy = InitialA[1][1]*InitialA[2][2] - InitialA[1][2]*InitialA[2][1]
        
        InitialA[1][0] =  randrange(1,3)
        InitialA[2][0] =  randrange(1,3)
        InitialA[0][0] =  randrange(1,3)
        InitialA[0][0] =  randrange(1,3)
        InitialA[0][1] =  randrange(1,3)
        InitialA[0][2] =  randrange(1,3)

        InitialB[0] = randrange(-20,-9)
        InitialB[1] = randrange(10,21)
        InitialB[2] = randrange(10,21)

        InitialC = [randrange(1,6), randrange(1,6), randrange(-5,6), ]
        shuffle(InitialC)
        
        

        V = self.simplexpivot(InitialA,InitialB,InitialC,InitialD,1,1).copy()
        InitialA[0] = V[0][0].copy()
        InitialA[1] = V[0][1].copy()
        InitialA[2] = V[0][2].copy()
        InitialB = V[1].copy()
        InitialC = V[2].copy()
        InitialD = V[3] 

        V = self.simplexpivot(InitialA,InitialB,InitialC,InitialD,2,2).copy()
        InitialA[0] = V[0][0].copy()
        InitialA[1] = V[0][1].copy()
        InitialA[2] = V[0][2].copy()
        InitialB = V[1].copy()
        InitialC = V[2].copy()
        InitialD = V[3]    

       

        

        scale = 1
        for i in range(3):
            for j in range(3):
                scale = lcm(InitialA[i][j].denominator(), scale)
        for i in range(3):
            InitialB[i] = InitialB[i]*scale
            for j in range(3):
                InitialA[i][j] = InitialA[i][j]*scale
        for j in range(3):
            InitialC[j] = InitialC[j]*scale        
        InitialD = InitialD*scale 

        ShuffleI = [0,1,2]
        #shuffle(ShuffleI)
        ShuffleJ = [0,1,2]
        shuffle(ShuffleJ)   

        NOA = [0,0,0,0]
        NOA[0] = InitialA[0].copy()
        NOA[1] = InitialA[1].copy()
        NOA[2] = InitialA[2].copy()
        NOB = InitialB.copy()
        NOC = InitialC.copy()
        NOD = InitialD

        for i in range(3):
            for j in range(3):    
                NOA[ShuffleI[i]][ShuffleJ[j]] = InitialA[i][j]

        for i in range(3):
            NOB[ShuffleI[i]] = InitialB[i]

        for j in range(3):
            NOC[ShuffleJ[j]] = InitialC[j]
            
            
            
        VarName = ["x_1", "x_2", "x_3",  "t_1", "t_2", "t_3",   ]
        TempVar = VarName.copy()

        FinalA = [0,0,0,0]
        FinalA[0] = NOA[0].copy()
        FinalA[1] = NOA[1].copy()
        FinalA[2] = NOA[2].copy()
        FinalB = NOB.copy()
        FinalC = NOC.copy()
        FinalD = NOD


        

        pivrow = ShuffleI[2]
        pivcol = ShuffleJ[2]
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
        VarName = TempVar.copy()  

        pivrow = ShuffleI[1]
        pivcol = ShuffleJ[1]
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
        VarName = TempVar.copy()   

        '''
        pivrow = ShuffleI[0]
        pivcol = ShuffleJ[0]
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
        VarName = TempVar.copy()  
        ''' 

        

        x1value = 0
        x2value = 0
        x3value = 0
        x4value = 0

        for i in range(3):
            if VarName[i+3] == "x_1":
                x1value = FinalB[i]
            if VarName[i+3] == "x_2":
                x2value = FinalB[i]
            if VarName[i+3] == "x_3":
                x3value = FinalB[i]  
                     
               

           

        

        
        
        

        tasks+=[ {
            "emptyregion": True,
            "Fa11": FinalA[0][0],
            "Fa12": FinalA[0][1],
            "Fa13": FinalA[0][2],
            "Fa21": FinalA[1][0],
            "Fa22": FinalA[1][1],
            "Fa23": FinalA[1][2],
            "Fa31": FinalA[2][0],
            "Fa32": FinalA[2][1],
            "Fa33": FinalA[2][2],
            "Fb1": FinalB[0],
            "Fb2": FinalB[1],
            "Fb3": FinalB[2],
            "Fc1": FinalC[0],
            "Fc2": FinalC[1],
            "Fc3": FinalC[2],
            "Fd": FinalD,
            "x1": VarName[0],
            "x2": VarName[1],
            "x3": VarName[2],
            "t1": VarName[3],
            "t2": VarName[4],
            "t3": VarName[5],
            # Initial
            "a11": NOA[0][0],
            "a12": NOA[0][1],
            "a13": NOA[0][2],
            "a21": NOA[1][0],
            "a22": NOA[1][1],
            "a23": NOA[1][2],
            "a31": NOA[2][0],
            "a32": NOA[2][1],
            "a33": NOA[2][2],
            "b1": NOB[0],
            "b2": NOB[1],
            "b3": NOB[2],
            "c1": NOC[0],
            "c2": NOC[1],
            "c3": NOC[2],
            "d": NOD,
            "objectivefunction": NOC[0]*x_1 + NOC[1]*x_2 + NOC[2]*x_3  - NOD,
            "row1": NOA[0][0]*x_1 + NOA[0][1]*x_2 + NOA[0][2]*x_3 ,
            "row2": NOA[1][0]*x_1 + NOA[1][1]*x_2 + NOA[1][2]*x_3,
            "row3": NOA[2][0]*x_1 + NOA[2][1]*x_2 + NOA[2][2]*x_3,
            "x1value": x1value,
            "x2value": x2value,
            "x3value": x3value,
            "optimalsolution": -1*FinalD,
        }]

        shuffle(tasks)
        return {"tasks": tasks}

    
    
