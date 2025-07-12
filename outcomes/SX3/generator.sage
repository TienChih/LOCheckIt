
class Generator(BaseGenerator):
    def data(self):
        

        # Unbounded objective 

        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badcol = randrange(0,5)
        C[badcol] = randrange(1,6)
        for i in range(5):
            A[i][badcol] = randrange(-5,1)
            B[i] = randrange(5,16)
        for j in range(5):
            if j != badcol:
                C[j] = randrange(-5,6)
                L = [0, randrange(-5,1), randrange(1,6), 0, randrange(-5,6), randrange(-5,6)]
                shuffle(L)
                for i in range(5):
                    A[i][j] = L[i]
        D = randrange(-10,11)

        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)

        tasks =  [{
            "unbregion": True,
            "unbobjective": True,
            "a11": A[0][0],
            "a12": A[0][1],
            "a13": A[0][2],
            "a14": A[0][3],
            "a15": A[0][4],
            "a21": A[1][0],
            "a22": A[1][1],
            "a23": A[1][2],
            "a24": A[1][3],
            "a25": A[1][4],
            "a31": A[2][0],
            "a32": A[2][1],
            "a33": A[2][2],
            "a34": A[2][3],
            "a35": A[2][4],
            "a41": A[3][0],
            "a42": A[3][1],
            "a43": A[3][2],
            "a44": A[3][3],
            "a45": A[3][4],
            "a51": A[4][0],
            "a52": A[4][1],
            "a53": A[4][2],
            "a54": A[4][3],
            "a55": A[4][4],
            "b1": B[0],
            "b2": B[1],
            "b3": B[2],
            "b4": B[3],
            "b5": B[4],
            "c1": C[0],
            "c2": C[1],
            "c3": C[2],
            "c4": C[3],
            "c5": C[4],
            "d": D,
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
        }]       

        # Unbounded region only 
        
        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badcol = randrange(0,5)
        C[badcol] = randrange(-5,0)
        for i in range(5):
            A[i][badcol] = randrange(-5,1)
            B[i] = randrange(5,16)
        for j in range(5):
            if j != badcol:
                C[j] = randrange(-5,6)
                L = [0, randrange(-5,1), randrange(1,6), 0, randrange(-5,6), randrange(-5,6)]
                shuffle(L)
                for i in range(5):
                    A[i][j] = L[i]
        D = randrange(-10,11)
        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)

        tasks +=  [{
            "unbregion": True,
            "unbobjective": False,
            "a11": A[0][0],
            "a12": A[0][1],
            "a13": A[0][2],
            "a14": A[0][3],
            "a15": A[0][4],
            "a21": A[1][0],
            "a22": A[1][1],
            "a23": A[1][2],
            "a24": A[1][3],
            "a25": A[1][4],
            "a31": A[2][0],
            "a32": A[2][1],
            "a33": A[2][2],
            "a34": A[2][3],
            "a35": A[2][4],
            "a41": A[3][0],
            "a42": A[3][1],
            "a43": A[3][2],
            "a44": A[3][3],
            "a45": A[3][4],
            "a51": A[4][0],
            "a52": A[4][1],
            "a53": A[4][2],
            "a54": A[4][3],
            "a55": A[4][4],
            "b1": B[0],
            "b2": B[1],
            "b3": B[2],
            "b4": B[3],
            "b5": B[4],
            "c1": C[0],
            "c2": C[1],
            "c3": C[2],
            "c4": C[3],
            "c5": C[4],
            "d": D,
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
        }]      


        # All good 

        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badrow = randrange(0,5)
        for j in range(5):
            A[badrow][j] = randrange(-5,1)
            B[j] = randrange(5,16)
        for j in range(5):
            L = [0, randrange(-5,1), randrange(1,6), 0, randrange(1,6), randrange(-5,6)]
            shuffle(L)
            for i in range(5):
                if i != badrow:
                    A[i][j] = L[i]
        C = [0, randrange(-5,1), randrange(1,6), 0, randrange(1,6), randrange(-5,6)]
        shuffle(C)            
        D = randrange(-10,11)
        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)

        tasks +=  [{
            "unbregion": False,
            "unbobjective": False,
            "a11": A[0][0],
            "a12": A[0][1],
            "a13": A[0][2],
            "a14": A[0][3],
            "a15": A[0][4],
            "a21": A[1][0],
            "a22": A[1][1],
            "a23": A[1][2],
            "a24": A[1][3],
            "a25": A[1][4],
            "a31": A[2][0],
            "a32": A[2][1],
            "a33": A[2][2],
            "a34": A[2][3],
            "a35": A[2][4],
            "a41": A[3][0],
            "a42": A[3][1],
            "a43": A[3][2],
            "a44": A[3][3],
            "a45": A[3][4],
            "a51": A[4][0],
            "a52": A[4][1],
            "a53": A[4][2],
            "a54": A[4][3],
            "a55": A[4][4],
            "b1": B[0],
            "b2": B[1],
            "b3": B[2],
            "b4": B[3],
            "b5": B[4],
            "c1": C[0],
            "c2": C[1],
            "c3": C[2],
            "c4": C[3],
            "c5": C[4],
            "d": D,
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
        }]         

        shuffle(tasks)

        return {"tasks": tasks}

    
    
    
    
