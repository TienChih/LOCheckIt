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



        point = [randrange(3,11),randrange(3,11),randrange(3,11),0]

        dummy1 = Rational(0)
        dummy2 = Rational(0)
        dummy3 = Rational(0)

        while min([min(InitialB), abs(dummy1), dummy2, dummy3]) <= 0:
            InitialB = [0,0,0,0]
            for i in range(4):
                for j in range(4):
                    InitialA[i][j] = choice([randrange(1,5), randrange(0,5)])
                    InitialB[i] += InitialA[i][j]*point[j]
                    

                if i == 3:
                    InitialB[3] += randrange(1,6)  
            M = matrix(QQ, [InitialA[0], InitialA[1], InitialA[2], [0,0,0,-1]]) 
            dummy1 = Rational(M.determinant() )
            if dummy1 != 0:
                MI = M.inverse() 
                InitialC = [0,0,0,0]
                Row = [0,0,0,-1]
                denom = randrange(5,11)
                c1 = randrange(1,denom)/denom
                c2 = randrange(1,denom)/denom
                c3 = randrange(1,denom)/denom
                c4 = randrange(1,denom)/denom
                for j in range(4): 
                    InitialC[j] = Rational(round(InitialA[0][j]*c1+InitialA[1][j]*c2+InitialA[2][j]*c3+Row[j]*c4))
                mC = matrix([InitialC])
                AfterC = mC*MI
                dummy2 = Rational(min([AfterC[0][0], AfterC[0][1], AfterC[0][2], AfterC[0][3], ]))
                dummy3 = Rational(min(InitialC))
                print(dummy2)

            
        
        
        print("done")

        
            


        ShuffleI = [0,1,2,3]
        shuffle(ShuffleI)
        ShuffleJ = [0,1,2,3]
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
            for j in range(4):    
                NOA[ShuffleI[i]][ShuffleJ[j]] = InitialA[i][j]

        for i in range(4):
            NOB[ShuffleI[i]] = InitialB[i]

        for j in range(4):
            NOC[ShuffleJ[j]] = InitialC[j]
            
            
            
        VarName = ["x_1", "x_2", "x_3", "x_4",  "t_1", "t_2", "t_3", "t_4",   ]
        TempVar = VarName.copy()

        FinalA = [NOA[0].copy(), NOA[1].copy(), NOA[2].copy(), NOA[3].copy(), 
        ]
        FinalB = NOB.copy()
        FinalC = NOC.copy()
        FinalD = 0

       

        

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

        y1value = 0
        y2value = 0
        y3value = 0
        y4value = 0
        

        for i in range(4):
            if VarName[i+4] == "x_1":
                x1value = FinalB[i]
            if VarName[i+4] == "x_2":
                x2value = FinalB[i]
            if VarName[i+4] == "x_3":
                x3value = FinalB[i]
            if VarName[i+4] == "x_4":
                x4value = FinalB[i]  
            if VarName[i] == "t_1":
                y1value = -1*FinalC[i]
            if VarName[i] == "t_2":
                y2value = -1*FinalC[i]
            if VarName[i] == "t_3":
                y3value = -1*FinalC[i]
            if VarName[i] == "t_4":
                y4value = -1*FinalC[i]      
            
             
        products_w = [
            "WindCell Generator",
            "WaveLite Panel",
            "WeldPro Torch",
            "WanderJet Scooter",
            "WristCom Device"
        ]

        products_x = [
            "XyloTrack Monitor",
            "Xentris Drone",
            "X-Core Battery",
            "Xypher Glasses",
            "X-Plore Scanner"
        ]

        products_y = [
            "YieldMate Harvester",
            "YaraTech Lamp",
            "Ypsilon Board",
            "YoctoBot Assistant",
            "YieldPro Irrigator"
        ]

        products_z = [
            "ZenithPod Drone",
            "ZyraFlex Console",
            "ZeroPoint Charger",
            "ZentraLock Safe",
            "Zypher Suit"
        ]

        # ------------------------
        # Materials by starting letter
        # ------------------------

        materials_a = [
            "AetherMesh",
            "Arcanite",
            "Auralium",
            "AxionFiber",
            "Amberite"
        ]

        materials_b = [
            "Biochrome",
            "Boronex",
            "Brimstone Alloy",
            "Basilite",
            "Biotex"
        ]

        materials_c = [
            "Carboflex",
            "Crytherm",
            "Celestrium",
            "Chromex",
            "Cortanite"
        ]

        materials_d = [
            "Duracene",
            "Deltanite",
            "Dynaflex",
            "Draconium",
            "Diaphene"
        ]
        

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
            "y1value": y1value,
            "y2value": y2value,
            "y3value": y3value,
            "y4value": y4value,
            "optimalsolution": -1*FinalD,
            "product1": choice(products_w),
            "product2": choice(products_x),
            "product3": choice(products_y),
            "product4": choice(products_w),
            "material1": choice(materials_a),
            "material2": choice(materials_b),
            "material3": choice(materials_c),
            "material4": choice(materials_d),
            
            
        }