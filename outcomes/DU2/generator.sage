class Generator(BaseGenerator):
    def data(self):
        
        dummyrandom = randrange(1,1000000)
        
        # Infeasible region 

        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badcolumn = randrange(0,5)
        C[badcolumn] = randrange(1,6)
        for i in range(5):
            A[i][badcolumn] = randrange(-5,0)
            B[i] = randrange(-5,6)
        for j in range(5):
            if j != badcolumn:
                C[j] = randrange(-5,1)
                L = [0, randrange(-5,1), randrange(1,6), 0, randrange(-5,6), randrange(-5,6)]
                shuffle(L)
                for i in range(5):
                    A[i][j] = L[i]
        D = randrange(-10,11)

        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)
        VarNameD = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        
        for i in range(len(VarName)):
            if VarName[i] == "x_1":
                VarNameD[i] = "s_1"
            if VarName[i] == "x_2":
                VarNameD[i] = "s_2"
            if VarName[i] == "x_3":
                VarNameD[i] = "s_3"
            if VarName[i] == "x_4":
                VarNameD[i] = "s_4"
            if VarName[i] == "x_5":
                VarNameD[i] = "s_5"
            if VarName[i] == "t_1":
                VarNameD[i] = "y_1"
            if VarName[i] == "t_2":
                VarNameD[i] = "y_2"
            if VarName[i] == "t_3":
                VarNameD[i] = "y_3"
            if VarName[i] == "t_4":
                VarNameD[i] = "y_4"
            if VarName[i] == "t_5":
                VarNameD[i] = "y_5"    

        tasks =  [{
            "infsolution": True,
            "infregion": True,
            "unboundedregion": False,
            "unboundedobjective": False,
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
            "s1": VarNameD[0],
            "s2": VarNameD[1],
            "s3": VarNameD[2],
            "s4": VarNameD[3],
            "s5": VarNameD[4],
            "y1": VarNameD[5],
            "y2": VarNameD[6],
            "y3": VarNameD[7],
            "y4": VarNameD[8],
            "y5": VarNameD[9],
        }]       

        # Infeasible solution only 
        
        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badcolumn = randrange(0,5)
        C[badcolumn] = randrange(1,6)
        L = [randrange(1,6), randrange(-5,6), randrange(-5,6), randrange(-5,6), randrange(-5,6)]
        shuffle(L)


        for i in range(5):
            A[i][badcolumn] = L[i]
            B[i] = randrange(-5,6)
        for j in range(5):
            if j != badcolumn:
                C[j] = randrange(-5,1)
                L = [0, randrange(-5,1), randrange(1,6), 0, randrange(-5,6), randrange(-5,6)]
                shuffle(L)
                for i in range(5):
                    A[i][j] = L[i]
        D = randrange(-10,11)
        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)
        VarNameD = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        
        for i in range(len(VarName)):
            if VarName[i] == "x_1":
                VarNameD[i] = "s_1"
            if VarName[i] == "x_2":
                VarNameD[i] = "s_2"
            if VarName[i] == "x_3":
                VarNameD[i] = "s_3"
            if VarName[i] == "x_4":
                VarNameD[i] = "s_4"
            if VarName[i] == "x_5":
                VarNameD[i] = "s_5"
            if VarName[i] == "t_1":
                VarNameD[i] = "y_1"
            if VarName[i] == "t_2":
                VarNameD[i] = "y_2"
            if VarName[i] == "t_3":
                VarNameD[i] = "y_3"
            if VarName[i] == "t_4":
                VarNameD[i] = "y_4"
            if VarName[i] == "t_5":
                VarNameD[i] = "y_5"    

        tasks +=  [{
            "infsolution": True,
            "infregion": False,
            "unboundedregion": False,
            "unboundedobjective": False,
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
            "s1": VarNameD[0],
            "s2": VarNameD[1],
            "s3": VarNameD[2],
            "s4": VarNameD[3],
            "s5": VarNameD[4],
            "y1": VarNameD[5],
            "y2": VarNameD[6],
            "y3": VarNameD[7],
            "y4": VarNameD[8],
            "y5": VarNameD[9],
        }]      


        # Unbounded region and objective

        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badrow = randrange(0,5)
        B[badrow] = randrange(-5,0)
        for i in range(5):
            A[badrow][i] = randrange(1,6)
            C[i] = randrange(-5,0)
        for j in range(5):
            if j != badrow:
                B[j] = randrange(1,6)
                L = [0, randrange(-5,1), randrange(1,6), 0, randrange(-5,6), randrange(-5,6)]
                shuffle(L)
                for i in range(5):
                    A[j][i] = L[i]
        D = randrange(-10,11)

        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)
        VarNameD = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        
        for i in range(len(VarName)):
            if VarName[i] == "x_1":
                VarNameD[i] = "s_1"
            if VarName[i] == "x_2":
                VarNameD[i] = "s_2"
            if VarName[i] == "x_3":
                VarNameD[i] = "s_3"
            if VarName[i] == "x_4":
                VarNameD[i] = "s_4"
            if VarName[i] == "x_5":
                VarNameD[i] = "s_5"
            if VarName[i] == "t_1":
                VarNameD[i] = "y_1"
            if VarName[i] == "t_2":
                VarNameD[i] = "y_2"
            if VarName[i] == "t_3":
                VarNameD[i] = "y_3"
            if VarName[i] == "t_4":
                VarNameD[i] = "y_4"
            if VarName[i] == "t_5":
                VarNameD[i] = "y_5"    

        tasks +=  [{
            "infsolution": False,
            "infregion": False,
            "unboundedregion": True,
            "unboundedobjective": True,
            "feasible": True,
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
            "s1": VarNameD[0],
            "s2": VarNameD[1],
            "s3": VarNameD[2],
            "s4": VarNameD[3],
            "s5": VarNameD[4],
            "y1": VarNameD[5],
            "y2": VarNameD[6],
            "y3": VarNameD[7],
            "y4": VarNameD[8],
            "y5": VarNameD[9],
        }]       

        # Unbounded region only 
        
        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badrow = randrange(0,5)
        B[badrow] = randrange(0,6)
        L = [randrange(1,6), randrange(0,6), randrange(0,6), randrange(0,6), randrange(1,6),]
        shuffle(L)


        for i in range(5):
            A[badrow][i] = L[i]
            C[i] = randrange(-5,0)
        for j in range(5):
            if j != badrow:
                B[j] = randrange(1,6)
                L = [0, randrange(-5,1), randrange(1,6), 0, randrange(-5,6), randrange(-5,6)]
                shuffle(L)
                for i in range(5):
                    A[j][i] = L[i]
        D = randrange(-10,11)
        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)
        VarNameD = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        
        for i in range(len(VarName)):
            if VarName[i] == "x_1":
                VarNameD[i] = "s_1"
            if VarName[i] == "x_2":
                VarNameD[i] = "s_2"
            if VarName[i] == "x_3":
                VarNameD[i] = "s_3"
            if VarName[i] == "x_4":
                VarNameD[i] = "s_4"
            if VarName[i] == "x_5":
                VarNameD[i] = "s_5"
            if VarName[i] == "t_1":
                VarNameD[i] = "y_1"
            if VarName[i] == "t_2":
                VarNameD[i] = "y_2"
            if VarName[i] == "t_3":
                VarNameD[i] = "y_3"
            if VarName[i] == "t_4":
                VarNameD[i] = "y_4"
            if VarName[i] == "t_5":
                VarNameD[i] = "y_5"    

        tasks +=  [{
            "infsolution": False,
            "infregion": False,
            "unboundedregion": True,
            "unboundedobjective": False,
            "feasible": True,
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
            "s1": VarNameD[0],
            "s2": VarNameD[1],
            "s3": VarNameD[2],
            "s4": VarNameD[3],
            "s5": VarNameD[4],
            "y1": VarNameD[5],
            "y2": VarNameD[6],
            "y3": VarNameD[7],
            "y4": VarNameD[8],
            "y5": VarNameD[9],
        }]      


        # Optimal 

        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badcol = randrange(0,5)
        C[badcol] = randrange(-5,0)
        for j in range(5):
            A[j][badcol] = randrange(-5,0)
            B[j] = randrange(1,6)
        for j in range(5):
            L = [0, randrange(-5,1), randrange(1,6), 0, randrange(1,6), randrange(-5,6)]
            shuffle(L)
            for i in range(5):
                if i != badcol:
                    A[j][i] = L[i]
                    C[i] = randrange(-5,0)
        
        shuffle(C)            
        D = randrange(-10,11)
        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)
        VarNameD = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        
        for i in range(len(VarName)):
            if VarName[i] == "x_1":
                VarNameD[i] = "s_1"
            if VarName[i] == "x_2":
                VarNameD[i] = "s_2"
            if VarName[i] == "x_3":
                VarNameD[i] = "s_3"
            if VarName[i] == "x_4":
                VarNameD[i] = "s_4"
            if VarName[i] == "x_5":
                VarNameD[i] = "s_5"
            if VarName[i] == "t_1":
                VarNameD[i] = "y_1"
            if VarName[i] == "t_2":
                VarNameD[i] = "y_2"
            if VarName[i] == "t_3":
                VarNameD[i] = "y_3"
            if VarName[i] == "t_4":
                VarNameD[i] = "y_4"
            if VarName[i] == "t_5":
                VarNameD[i] = "y_5"    

        tasks +=  [{
            "infsolution": False,
            "infregion": False,
            "unboundedregion": False,
            "unboundedobjective": False,
            "optimal": True,
            "feasible": True,
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
            "s1": VarNameD[0],
            "s2": VarNameD[1],
            "s3": VarNameD[2],
            "s4": VarNameD[3],
            "s5": VarNameD[4],
            "y1": VarNameD[5],
            "y2": VarNameD[6],
            "y3": VarNameD[7],
            "y4": VarNameD[8],
            "y5": VarNameD[9],
        }]         


        # Fine 

        A = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],]
        B = [0,0,0,0,0]
        C = [0,0,0,0,0]

        badcol = randrange(0,5)
        C[badcol] = randrange(-5,0)
        L = [randrange(-5,0), randrange(-5,6), randrange(-5,6), randrange(-5,6), randrange(-5,6), ]
        shuffle(L)
        B = L.copy()
        for j in range(5):
            A[j][badcol] = randrange(-5,0)
        for j in range(5):
            L = [0, randrange(-5,1), randrange(1,6), 0, randrange(1,6), randrange(-5,6)]
            shuffle(L)
            for i in range(5):
                if i != badcol:
                    A[j][i] = L[i]
                    C[i] = randrange(-5,0)
        
        shuffle(C)            
        D = randrange(-10,11)
        VarName = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        shuffle(VarName)
        VarNameD = ["x_1", "x_2", "x_3", "x_4", "x_5", "t_1", "t_2", "t_3", "t_4", "t_5", ]
        
        for i in range(len(VarName)):
            if VarName[i] == "x_1":
                VarNameD[i] = "s_1"
            if VarName[i] == "x_2":
                VarNameD[i] = "s_2"
            if VarName[i] == "x_3":
                VarNameD[i] = "s_3"
            if VarName[i] == "x_4":
                VarNameD[i] = "s_4"
            if VarName[i] == "x_5":
                VarNameD[i] = "s_5"
            if VarName[i] == "t_1":
                VarNameD[i] = "y_1"
            if VarName[i] == "t_2":
                VarNameD[i] = "y_2"
            if VarName[i] == "t_3":
                VarNameD[i] = "y_3"
            if VarName[i] == "t_4":
                VarNameD[i] = "y_4"
            if VarName[i] == "t_5":
                VarNameD[i] = "y_5"                    

        tasks +=  [{
            "infsolution": False,
            "infregion": False,
            "unboundedregion": False,
            "unboundedobjective": False,
            "optimal": False,
            "feasible": True,
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
            "s1": VarNameD[0],
            "s2": VarNameD[1],
            "s3": VarNameD[2],
            "s4": VarNameD[3],
            "s5": VarNameD[4],
            "y1": VarNameD[5],
            "y2": VarNameD[6],
            "y3": VarNameD[7],
            "y4": VarNameD[8],
            "y5": VarNameD[9],
        }]         

        shuffle(tasks)

        return {"tasks": tasks}

