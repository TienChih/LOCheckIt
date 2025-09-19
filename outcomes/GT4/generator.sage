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


        scenario = "cards" #choice(["cards", "difference", "blotto", "evenodd"])

        if scenario == "cards":
            pool = 5 * randrange(4,9)
            bet = 5*randrange(1,9)      
                       
            A = [[0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],]
            
            for i in range(8):
                if i == 0:
                    RS = [0,0,0]
                elif i == 1:
                    RS = [0,0,1]
                elif i == 2:
                    RS = [0,1,0]        
                elif i == 3:
                    RS = [1,0,0]    
                elif i == 4:
                    RS = [0,1,1]
                elif i == 5:
                    RS = [1,0,1]        
                elif i == 6:
                    RS = [1,1,0]    
                elif i == 7:
                    RS = [1,1,1]    
                for j in range(8):
                    if j == 0:
                        CS = [0,0,0]
                    elif j == 1:
                        CS = [0,0,1]
                    elif j == 2:
                        CS = [0,1,0]        
                    elif j == 3:
                        CS = [1,0,0]    
                    elif j == 4:
                        CS = [0,1,1]
                    elif j == 5:
                        CS = [1,0,1]        
                    elif j == 6:
                        CS = [1,1,0]    
                    elif j == 7:
                        CS = [1,1,1]
                    ExpectedValue = 0    
                    for x in range(3):
                        for y in range(3):
                            if x == y:
                                prob = (1/3) * (3/11)
                            else:
                                prob = (1/3)*(4/11)    
                            if RS[x] == 0:
                                ExpectedValue += -1*pool*prob
                            elif RS[x] == 1 and CS[y] == 0:
                                ExpectedValue += (pool)*prob
                            elif RS[x] == 1 and CS[y] == 1 and x>y:
                                ExpectedValue += (pool+bet)*prob   
                            elif RS[x] == 1 and CS[y] == 1 and x<y:
                                ExpectedValue += -1*(pool+bet)*prob
                            elif RS[x] == 1 and CS[y] == 1 and x == y:
                                ExpectedValue += 0
                    A[i][j] = ExpectedValue                                

            data = []
            C = []
            col = [{"col":"FFF"}, {"col":"FFC"}, {"col":"FCF"}, {"col":"CFF"}, {"col":"FCC"}, {"col":"CFC"}, {"col":"CCF"}, {"col":"CCC"}, ]

            for i in range(8):
                C.append({"c":"c"})

            for i in range(8):
                data2 = []
                for j in range(8):
                    data2.append({"entry":A[i][j]})
                if i == 0:    
                    data.append({"row": "FFF", "data2":data2})   
                if i == 1:    
                    data.append({"row": "FFR", "data2":data2})       
                if i == 2:    
                    data.append({"row": "FRF", "data2":data2}) 
                if i == 3:    
                    data.append({"row": "RFF", "data2":data2})
                if i == 4:    
                    data.append({"row": "FRR", "data2":data2})
                if i == 5:    
                    data.append({"row": "RFR", "data2":data2})
                if i == 6:    
                    data.append({"row": "RRF", "data2":data2})
                if i == 7:    
                    data.append({"row": "RRR", "data2":data2})                                         




            return {
                scenario: True,
                "data": data,   
                "C": C,   
                "col": col,  
                "pool": pool,
                "bet": bet,     
                
            }             

        # DIFFERENCE    
        
        if scenario == "difference":
            
            n= 2 * randrange(3,6)
            m = n/2
            A = [0]*n
            for i in range(n):
                A[i] = ([0]*n).copy()

            for i in range(n):
                for j in range(n):
                    if abs(i-j) < m:
                        if i > j:
                            A[i][j] = -1*(i + j + 2)
                        if i < j:
                            A[i][j] = -1*(-i - j - 2    )
                    else:
                        if i < j:
                            A[i][j] = -1*(i + j + 2)
                        if i > j:
                            A[i][j] = -1*(-i - j - 2    )

            data = []
            C = []
            col = []

            for i in range(n):
                C.append({"c":"c"})
                col.append({"col":i+1})

            for i in range(n):
                data2 = []
                for j in range(n):
                    data2.append({"entry":A[i][j]})
                data.append({"row": i+1, "data2":data2})      
            
            return {
                scenario: True,
                "data": data,   
                "C": C,   
                "col": col,  
                "m": m,  
                "n": n,     
                
            }     
            
        # BLOTTO    
        
        if scenario == "blotto":
            
            Rtroop =  randrange(4,8)
            Ctroop = Rtroop + randrange(0,4)
            A = [0]*(Ctroop+1)
            for i in range(Ctroop+1):
                A[i] = ([0]*(Rtroop+1)).copy()

            for i in range(Ctroop+1):
                for j in range(Rtroop+1):
                    if i-j > 0:
                        A[i][j] += -1*j  
                    if i-j < 0:
                        A[i][j] += i+1
                    if (Ctroop-i)-(Rtroop-j) > 0:
                        A[i][j] += -1*(Rtroop-j)  
                    if (Ctroop-i)-(Rtroop-j) < 0:
                        A[i][j] += (Ctroop-i) +1   
                              

            data = []
            C = []
            col = []

            for i in range(Rtroop+1):
                C.append({"c":"c"})
                col.append({"col":(i, Rtroop-i)})

            for i in range(Ctroop+1):
                data2 = []
                for j in range(Rtroop+1):
                    data2.append({"entry":A[i][j]})
                data.append({"row": (i, Ctroop-i), "data2":data2})      
            
            return {
                scenario: True,
                "data": data,   
                "C": C,   
                "col": col,  
                "Rtroop": Rtroop,  
                "Ctroop": Ctroop,     
                
            }   
        
        # EvenOdd    
        
        if scenario == "evenodd":
            
            n = randrange(3,6)
            A = [0]*n
            for i in range(n):
                A[i] = ([0]*n).copy()

            for i in range(n):
                for j in range(n):
                    if i == j:
                        A[i][j] = -i-j-2
                    elif (i+j)%2 == 0:
                        A[i][j] = -1*abs(i-j)
                    else:
                        A[i][j] = n    

            data = []
            C = []
            col = []


            for i in range(n):
                C.append({"c":"c"})
                col.append({"col":i+1})

            for i in range(n):
                data2 = []
                for j in range(n):
                    data2.append({"entry":A[i][j]})
                data.append({"row": i+1, "data2":data2})      
            
            return {
                scenario: True,
                "data": data,   
                "C": C,   
                "col": col,  
                "n": n,     
                
            }         