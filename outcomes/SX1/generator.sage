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
            
            
        }

    
    
