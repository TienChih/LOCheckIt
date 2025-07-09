class Generator(BaseGenerator):
    def data(self):
        
        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        while A[0][0] == A[1][0]:
            CD = randrange(2,5)
            A[0][0] = CD * randrange(1,3)
            A[1][0] = CD * randrange(1,3)

        A[2][0] = randrange(0,9)
        A[3][0] = randrange(0,9)
        A[4][0] = randrange(-9,1)

        R = randrange(1,8)/CD
        B[0] = ceil(A[0][0]*R )
        B[1] = ceil(A[1][0]*R )
        B[2] = randrange(ceil(A[2][0]*R)+1, ceil(A[2][0]*R)+6)
        B[3] = randrange(ceil(A[3][0]*R)+1, ceil(A[3][0]*R)+6)
        B[4] = randrange(1,26)

        tempR = [0,0,0,0,0]

        while tempR[1] == tempR[2] or tempR[1] == tempR[0]:
            A[0][1] = randrange(1,9)
            A[1][1] = randrange(1,9)
            A[2][1] = randrange(1,9)
            A[3][1] = randrange(1,9)
            A[4][1] = randrange(1,9)
            for i in range(5):
                tempR[i] = B[i]/A[i][1]
            tempR.sort()

        smol = tempR[0]

        for i in range(5):
            if B[i]/A[i][1] == smol:
                A[i][1] = -1*A[i][1]
            if B[i]/A[i][1] == tempR[1]:     
                pivot3 = i

        for i in range(2,5):
            for j in range(0,5):
                A[j][i] = randrange(-8,9)

        while C[0]+C[1] == 0:
            C = [randrange(0,6), randrange(0,6), randrange(-5,0), randrange(-5,0), randrange(-5,0), ]        


        ShuffleI = [0,1,2,3,4]
        shuffle(ShuffleI)
        ShuffleJ = [0,1,2,3,4]
        shuffle(ShuffleJ)

        FinalA = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        FinalB = [0,0,0,0,0]
        FinalC = [0,0,0,0,0]

        for i in range(5):
            for j in range(5):
                FinalA[ShuffleI[i]][ShuffleJ[j]] = A[i][j]
                FinalB[ShuffleI[i]] = B[i]
                FinalC[ShuffleJ[j]] = C[j]

        
        FinalD = randrange(-20,21)
        

        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)


        Ap1 = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        Bp1 = [0,0,0,0,0]
        Cp1 = [0,0,0,0,0]
        Dp1 = 0
        Varp1 = [0,0,0,0,0,0,0,0,0,0]

        pivotvalue1 = FinalA[ShuffleI[0]][ShuffleJ[0]]
        for i in range(5):
            for j in range(5):
                if i == ShuffleI[0]:
                    if j == ShuffleJ[0]:
                        Ap1[ShuffleI[0]][ShuffleJ[0]] = Rational(1/pivotvalue1)
                    else:
                        Ap1[i][j] = Rational(FinalA[i][j]/pivotvalue1  )
                elif j == ShuffleJ[0]:
                    Ap1[i][j] = Rational(-1*FinalA[i][j]/pivotvalue1  )
                else:
                    Ap1[i][j] = FinalA[i][j] - Rational(FinalA[i][ShuffleJ[0]]*FinalA[ShuffleI[0]][j]/pivotvalue1  )

        for i in range(5):
            if i == ShuffleI[0]:
                Bp1[i] = Rational(FinalB[i]/pivotvalue1)
            else:
                Bp1[i] = FinalB[i] - Rational(FinalA[i][ShuffleJ[0]]*FinalB[ShuffleI[0]]/pivotvalue1  )
            if i == ShuffleJ[0]:
                Cp1[i] = Rational(-1*FinalC[i]/pivotvalue1)
            else:
                Cp1[i] = FinalC[i] - Rational(FinalC[ShuffleJ[0]]*FinalA[ShuffleI[0]][i]/pivotvalue1)
        Dp1 = FinalD - Rational(FinalB[ShuffleI[0]]*FinalC[ShuffleJ[0]]/pivotvalue1)

        for i in range(10):
            if i == ShuffleJ[0]:
                Varp1[i] = VarName[5+ShuffleI[0]]
            elif i == ShuffleI[0]+5:  
                Varp1[i] = VarName[ShuffleJ[0]]
            else:
                Varp1[i] = VarName[i]    


        Ap2 = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        Bp2 = [0,0,0,0,0]
        Cp2 = [0,0,0,0,0]
        Dp2 = 0
        Varp2 = [0,0,0,0,0,0,0,0,0,0]

        pivotvalue2 = FinalA[ShuffleI[1]][ShuffleJ[0]]
        for i in range(5):
            for j in range(5):
                if i == ShuffleI[1]:
                    if j == ShuffleJ[0]:
                        Ap2[ShuffleI[1]][ShuffleJ[0]] = Rational(1/pivotvalue2)
                    else:
                        Ap2[i][j] = Rational(FinalA[i][j]/pivotvalue2  )
                elif j == ShuffleJ[0]:
                    Ap2[i][j] = Rational(-1*FinalA[i][j]/pivotvalue2  )
                else:
                    Ap2[i][j] = FinalA[i][j] - Rational(FinalA[i][ShuffleJ[0]]*FinalA[ShuffleI[1]][j]/pivotvalue2  )

        for i in range(5):
            if i == ShuffleI[1]:
                Bp2[i] = Rational(FinalB[i]/pivotvalue2)
            else:
                Bp2[i] = FinalB[i] - Rational(FinalA[i][ShuffleJ[0]]*FinalB[ShuffleI[1]]/pivotvalue2  )
            if i == ShuffleJ[0]:
                Cp2[i] = Rational(-1*FinalC[i]/pivotvalue2)
            else:
                Cp2[i] = FinalC[i] - Rational(FinalC[ShuffleJ[0]]*FinalA[ShuffleI[1]][i]/pivotvalue2)
        Dp2 = FinalD - Rational(FinalB[ShuffleI[1]]*FinalC[ShuffleJ[0]]/pivotvalue2)

        for i in range(10):
            if i == ShuffleJ[0]:
                Varp2[i] = VarName[5+ShuffleI[1]]
            elif i == ShuffleI[1]+5:  
                Varp2[i] = VarName[ShuffleJ[0]]
            else:
                Varp2[i] = VarName[i]   


        Ap3 = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        Bp3 = [0,0,0,0,0]
        Cp3 = [0,0,0,0,0]
        Dp3 = 0
        Varp3 = [0,0,0,0,0,0,0,0,0,0]

        pivotvalue3 = FinalA[ShuffleI[pivot3]][ShuffleJ[1]]
        for i in range(5):
            for j in range(5):
                if i == ShuffleI[pivot3]:
                    if j == ShuffleJ[1]:
                        Ap3[ShuffleI[pivot3]][ShuffleJ[1]] = Rational(1/pivotvalue3)
                    else:
                        Ap3[i][j] = Rational(FinalA[i][j]/pivotvalue3  )
                elif j == ShuffleJ[1]:
                    Ap3[i][j] = Rational(-1*FinalA[i][j]/pivotvalue3  )
                else:
                    Ap3[i][j] = FinalA[i][j] - Rational(FinalA[i][ShuffleJ[1]]*FinalA[ShuffleI[pivot3]][j]/pivotvalue3  )

        for i in range(5):
            if i == ShuffleI[pivot3]:
                Bp3[i] = Rational(FinalB[i]/pivotvalue3)
            else:
                Bp3[i] = FinalB[i] - Rational(FinalA[i][ShuffleJ[1]]*FinalB[ShuffleI[pivot3]]/pivotvalue3  )
            if i == ShuffleJ[1]:
                Cp3[i] = Rational(-1*FinalC[i]/pivotvalue3)
            else:
                Cp3[i] = FinalC[i] - Rational(FinalC[ShuffleJ[1]]*FinalA[ShuffleI[pivot3]][i]/pivotvalue3)
        Dp3 = FinalD - Rational(FinalB[ShuffleI[pivot3]]*FinalC[ShuffleJ[1]]/pivotvalue3)

        for i in range(10):
            if i == ShuffleJ[1]:
                Varp3[i] = VarName[5+ShuffleI[pivot3]]
            elif i == ShuffleI[pivot3]+5:  
                Varp3[i] = VarName[ShuffleJ[1]]
            else:
                Varp3[i] = VarName[i]                                         

        return {
            "a11": FinalA[0][0],
            "a12": FinalA[0][1],
            "a13": FinalA[0][2],
            "a14": FinalA[0][3],
            "a15": FinalA[0][4],
            "a21": FinalA[1][0],
            "a22": FinalA[1][1],
            "a23": FinalA[1][2],
            "a24": FinalA[1][3],
            "a25": FinalA[1][4],
            "a31": FinalA[2][0],
            "a32": FinalA[2][1],
            "a33": FinalA[2][2],
            "a34": FinalA[2][3],
            "a35": FinalA[2][4],
            "a41": FinalA[3][0],
            "a42": FinalA[3][1],
            "a43": FinalA[3][2],
            "a44": FinalA[3][3],
            "a45": FinalA[3][4],
            "a51": FinalA[4][0],
            "a52": FinalA[4][1],
            "a53": FinalA[4][2],
            "a54": FinalA[4][3],
            "a55": FinalA[4][4],
            "b1": FinalB[0],
            "b2": FinalB[1],
            "b3": FinalB[2],
            "b4": FinalB[3],
            "b5": FinalB[4],
            "c1": FinalC[0],
            "c2": FinalC[1],
            "c3": FinalC[2],
            "c4": FinalC[3],
            "c5": FinalC[4],
            "d": FinalD,
            "pv1i": ShuffleI[0]+1,
            "pv1j": ShuffleJ[0]+1,
            "pv2i": ShuffleI[1]+1,
            "pv2i": ShuffleI[1]+1,
            "pv2j": ShuffleJ[0]+1,
            "pv3i": ShuffleI[pivot3]+1,
            "pv3j": ShuffleJ[1]+1,
            "x1": VarName[0],
            "x2": VarName[1],
            "x3": VarName[2],
            "x4": VarName[3],
            "x5": VarName[4],
            "t1": VarName[5],
            "t2": VarName[6],
            "t3": VarName[7],
            "t4": VarName[8],
            "t5": VarName[9],
            # pivot 1
            "p1a11": Ap1[0][0],
            "p1a12": Ap1[0][1],
            "p1a13": Ap1[0][2],
            "p1a14": Ap1[0][3],
            "p1a15": Ap1[0][4],
            "p1a21": Ap1[1][0],
            "p1a22": Ap1[1][1],
            "p1a23": Ap1[1][2],
            "p1a24": Ap1[1][3],
            "p1a25": Ap1[1][4],    
            "p1a31": Ap1[2][0],
            "p1a32": Ap1[2][1],
            "p1a33": Ap1[2][2],
            "p1a34": Ap1[2][3],
            "p1a35": Ap1[2][4],    
            "p1a41": Ap1[3][0],
            "p1a42": Ap1[3][1],
            "p1a43": Ap1[3][2],
            "p1a44": Ap1[3][3],
            "p1a45": Ap1[3][4],    
            "p1a51": Ap1[4][0],
            "p1a52": Ap1[4][1],
            "p1a53": Ap1[4][2],
            "p1a54": Ap1[4][3],
            "p1a55": Ap1[4][4],    
            "p1b1": Bp1[0],
            "p1b2": Bp1[1],
            "p1b3": Bp1[2],
            "p1b4": Bp1[3],
            "p1b5": Bp1[4],    
            "p1c1": Cp1[0],
            "p1c2": Cp1[1],
            "p1c3": Cp1[2],
            "p1c4": Cp1[3],
            "p1c5": Cp1[4],    
            "p1d": Dp1,
            "p1x1": Varp1[0],
            "p1x2": Varp1[1],
            "p1x3": Varp1[2],
            "p1x4": Varp1[3],
            "p1x5": Varp1[4],
            "p1t1": Varp1[5],
            "p1t2": Varp1[6],
            "p1t3": Varp1[7],
            "p1t4": Varp1[8],
            "p1t5": Varp1[9],
            # pivot 2
            "p2a11": Ap2[0][0],
            "p2a12": Ap2[0][1],
            "p2a13": Ap2[0][2],
            "p2a14": Ap2[0][3],
            "p2a15": Ap2[0][4],
            "p2a21": Ap2[1][0],
            "p2a22": Ap2[1][1],
            "p2a23": Ap2[1][2],
            "p2a24": Ap2[1][3],
            "p2a25": Ap2[1][4],    
            "p2a31": Ap2[2][0],
            "p2a32": Ap2[2][1],
            "p2a33": Ap2[2][2],
            "p2a34": Ap2[2][3],
            "p2a35": Ap2[2][4],    
            "p2a41": Ap2[3][0],
            "p2a42": Ap2[3][1],
            "p2a43": Ap2[3][2],
            "p2a44": Ap2[3][3],
            "p2a45": Ap2[3][4],    
            "p2a51": Ap2[4][0],
            "p2a52": Ap2[4][1],
            "p2a53": Ap2[4][2],
            "p2a54": Ap2[4][3],
            "p2a55": Ap2[4][4],    
            "p2b1": Bp2[0],
            "p2b2": Bp2[1],
            "p2b3": Bp2[2],
            "p2b4": Bp2[3],
            "p2b5": Bp2[4],    
            "p2c1": Cp2[0],
            "p2c2": Cp2[1],
            "p2c3": Cp2[2],
            "p2c4": Cp2[3],
            "p2c5": Cp2[4],    
            "p2d": Dp2,
            "p2x1": Varp2[0],
            "p2x2": Varp2[1],
            "p2x3": Varp2[2],
            "p2x4": Varp2[3],
            "p2x5": Varp2[4],
            "p2t1": Varp2[5],
            "p2t2": Varp2[6],
            "p2t3": Varp2[7],
            "p2t4": Varp2[8],
            "p2t5": Varp2[9],
            # pivot 3
            "p3a11": Ap3[0][0],
            "p3a12": Ap3[0][1],
            "p3a13": Ap3[0][2],
            "p3a14": Ap3[0][3],
            "p3a15": Ap3[0][4],
            "p3a21": Ap3[1][0],
            "p3a22": Ap3[1][1],
            "p3a23": Ap3[1][2],
            "p3a24": Ap3[1][3],
            "p3a25": Ap3[1][4],    
            "p3a31": Ap3[2][0],
            "p3a32": Ap3[2][1],
            "p3a33": Ap3[2][2],
            "p3a34": Ap3[2][3],
            "p3a35": Ap3[2][4],    
            "p3a41": Ap3[3][0],
            "p3a42": Ap3[3][1],
            "p3a43": Ap3[3][2],
            "p3a44": Ap3[3][3],
            "p3a45": Ap3[3][4],    
            "p3a51": Ap3[4][0],
            "p3a52": Ap3[4][1],
            "p3a53": Ap3[4][2],
            "p3a54": Ap3[4][3],
            "p3a55": Ap3[4][4],    
            "p3b1": Bp3[0],
            "p3b2": Bp3[1],
            "p3b3": Bp3[2],
            "p3b4": Bp3[3],
            "p3b5": Bp3[4],    
            "p3c1": Cp3[0],
            "p3c2": Cp3[1],
            "p3c3": Cp3[2],
            "p3c4": Cp3[3],
            "p3c5": Cp3[4],    
            "p3d": Dp3,
            "p3x1": Varp3[0],
            "p3x2": Varp3[1],
            "p3x3": Varp3[2],
            "p3x4": Varp3[3],
            "p3x5": Varp3[4],
            "p3t1": Varp3[5],
            "p3t2": Varp3[6],
            "p3t3": Varp3[7],
            "p3t4": Varp3[8],
            "p3t5": Varp3[9],
            
            
        }

    
    
