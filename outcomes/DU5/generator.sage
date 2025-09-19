class Generator(BaseGenerator):
    def simplexpivot(self,xA,xB,xC,xD,I,J):
        tempA = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
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
        var('x_1 x_2 x_3 x_4 y_1 y_2 y_3 y_4')
        
        InitialA = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
        InitialB = [0,0,0,0]
        InitialC = [0,0,0,0]
        InitialD = randrange(-20,3)

        dummyrandom = randrange(1,1000000)

        
        smallB = -1
        while smallB <= 0:
            InitialB = [0,0,0,0]
            point = [randrange(1,6), 0, randrange(1,6), randrange(-3,0), ]
            dummy = 0
            while dummy == 0:
                for i in range(4):
                    for j in range(4):
                        InitialA[i][j] = choice([randrange(-3,4), randrange(1,4), randrange(0,4)])
                        InitialA[i][j] = choice([randrange(-3,4), randrange(1,4), randrange(0,4)])
                InitialA[3][3]    = 0    
                M1 = matrix([[1,0,0,0], [0,1,0,0], InitialA[3], [0,0,0,1]])
                M2 = matrix([[1,0,0,0], [0,1,0,0], InitialA[2], InitialA[3]])
                M3 = matrix([InitialA[0], [0,1,0,0], InitialA[2], InitialA[3]])
                dummy = M1.determinant() * M2.determinant() * M3.determinant()
            for i in range(4):
                for j in range(4):
                    InitialB[i] += InitialA[i][j] * point[j]
            InitialB[1] += randrange(1,6)
            smallB = min(InitialB)

        Co = [1,1,1,2,2,2]
        shuffle(Co)

        for i in [0,2,3]:
            for j in range(4):
                InitialC[j]+= InitialA[i][j]*Co[i]
        InitialC[1] += randrange(-2,0)        


    
        
        

        Dummy = [0,1,2]
        shuffle(Dummy)
        ShuffleI = Dummy+[3]
        Dummy = [0,1,2]
        shuffle(Dummy)
        ShuffleJ = Dummy+[3]  

        NOA = [0,0,0,0]
        NOA[0] = InitialA[0].copy()
        NOA[1] = InitialA[1].copy()
        NOA[2] = InitialA[2].copy()
        NOA[3] = InitialA[3].copy()
        NOB = InitialB.copy()
        NOC = InitialC.copy()
        NOD = InitialD

        for i in range(4):
            for j in range(4):    
                NOA[ShuffleI[i]][ShuffleJ[j]] = InitialA[i][j]

        for i in range(4):
            NOB[ShuffleI[i]] = InitialB[i]

        for j in range(4):
            NOC[ShuffleJ[j]] = InitialC[j]
            
            
            
        VarName = ["x_1", "x_2",  "x_3", "x_4", "t_1",  "t_2" , "t_3",  "t_4" ]
        TempVar = VarName.copy()

        FinalA = [0,0,0,0]
        FinalA[0] = NOA[0].copy()
        FinalA[1] = NOA[1].copy()
        FinalA[2] = NOA[2].copy()
        FinalA[3] = NOA[3].copy()
        FinalB = NOB.copy()
        FinalC = NOC.copy()
        FinalD = NOD


        

        pivrow = ShuffleI[3]
        pivcol = ShuffleJ[2]
        V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
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


        pivrow = ShuffleI[2]
        pivcol = ShuffleJ[3]
        V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
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

        pivrow = ShuffleI[0]
        pivcol = ShuffleJ[0]
        V = self.simplexpivot(FinalA,FinalB,FinalC,FinalD,pivrow,pivcol).copy()
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

        VarNameD = VarName.copy()

        for i in range(len(VarName)):
            if VarName[i] == "x_1":
                VarNameD[i] = "s_1"
            if VarName[i] == "x_2":
                VarNameD[i] = "s_2"
            if VarName[i] == "x_3":
                VarNameD[i] = "s_3"
            if VarName[i] == "x_4":
                VarNameD[i] = "s_4"    
            if VarName[i] == "t_1":
                VarNameD[i] = "y_1"
            if VarName[i] == "t_2":
                VarNameD[i] = "y_2"
            if VarName[i] == "t_3":
                VarNameD[i] = "y_3"
            if VarName[i] == "t_4":
                VarNameD[i] = "y_4"    

        y1value = 0
        y2value = 0
        y3value = 0
        y4value = 0
        

        for i in range(4):
            if VarNameD[i] == "y_1":
                y1value = -1*FinalC[i]
            if VarNameD[i] == "y_2":
                y2value = -1*FinalC[i]
            if VarNameD[i] == "y_3":
                y3value = -1*FinalC[i]
            if VarNameD[i] == "y_4":
                y4value = -1*FinalC[i]    
             
                     
               

           

        

        
        
        OI = [ShuffleI[0], ShuffleI[1], ShuffleI[3]]
        OI.sort()

        OJ = [ShuffleJ[0], ShuffleJ[1], ShuffleJ[3]]
        OJ.sort()

        return {
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
            "t1": VarName[4+OI[0]],
            "t2": VarName[4+OI[1]],
            "t3": VarName[4+OI[2]],
            "s1": VarNameD[OJ[0]],
            "s2": VarNameD[OJ[1]],
            "s3": VarNameD[OJ[2]],
            #"x4": VarName[3],
            "y1": VarNameD[4+OI[0]],
            "y2": VarNameD[4+OI[1]],
            "y3": VarNameD[4+OI[2]],
            #"t4": VarName[7],
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
            "dualfunction": NOB[0]*y_1 + NOB[1]*y_2 + NOB[2]*y_3 + NOB[3]*y_4 - NOD ,
            "drow1": NOA[0][0]*y_1 + NOA[1][0]*y_2 + NOA[2][0]*y_3 + NOA[3][0]*y_4,
            "drow2": NOA[0][1]*y_1 + NOA[1][1]*y_2 + NOA[2][1]*y_3 + NOA[3][1]*y_4,
            "drow3": NOA[0][2]*y_1 + NOA[1][2]*y_2 + NOA[2][2]*y_3 + NOA[3][2]*y_4,
            "drow4": NOA[0][3]*y_1 + NOA[1][3]*y_2 + NOA[2][3]*y_3 + NOA[3][3]*y_4,
            "y1value": y1value,
            "y2value": y2value,
            "y3value": y3value,
            "y4value": y4value,
            "optimalsolution": -1*FinalD
        }