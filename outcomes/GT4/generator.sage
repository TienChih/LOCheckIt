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


        scenario = choice(["cards", "coins", "dice"])

        if scenario == "cards":
            pool = 5 * randrange(4,19)
            bet = 5*randrange(1,19)      
                       
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
        
        
        #coins
        
        
        if scenario == "coins":
            pool = 5 * randrange(4,19)
            bet = 5*randrange(1,19)      
                       
            A = [[0,0,0,0,0,0,0,0,],
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
                            Px = 1/4
                            Py = 1/4
                            if x == 1:
                                Px = 1/2
                            if y == 1:
                                Py = 1/2
                            prob = Px*Py            
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
            
            

            #dice
        
        
        if scenario == "dice":
            pool = 5 * randrange(4,19)
            bet = 5*randrange(1,19)      
                       
            A = [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],]
            
            for i in range(16):
                if i == 0:
                    RS = [0,0,0,0]
                elif i == 1:
                    RS = [0,0,0,1]
                elif i == 2:
                    RS = [0,0,1,0]        
                elif i == 3:
                    RS = [0,0,1,1]    
                elif i == 4:
                    RS = [0,1,0,0]
                elif i == 5:
                    RS = [0,1,0,1]        
                elif i == 6:
                    RS = [0,1,1,0]    
                elif i == 7:
                    RS = [0,1,1,1]  
                elif i == 8:
                    RS = [1,0,0,0]
                elif i == 9:
                    RS = [1,0,0,1]
                elif i == 10:
                    RS = [1,0,1,0]        
                elif i == 11:
                    RS = [1,0,1,1]    
                elif i == 12:
                    RS = [1,1,0,0]
                elif i == 13:
                    RS = [1,1,0,1]        
                elif i == 14:
                    RS = [1,1,1,0]    
                elif i == 15:
                    RS = [1,1,1,1]        
                for j in range(16):
                    if j == 0:
                        CS = [0,0,0,0]
                    elif j == 1:
                        CS = [0,0,0,1]
                    elif j == 2:
                        CS = [0,0,1,0]        
                    elif j == 3:
                        CS = [0,0,1,1]    
                    elif j == 4:
                        CS = [0,1,0,0]
                    elif j == 5:
                        CS = [0,1,0,1]        
                    elif j == 6:
                        CS = [0,1,1,0]    
                    elif j == 7:
                        CS = [0,1,1,1]  
                    elif j == 8:
                        CS = [1,0,0,0]
                    elif j == 9:
                        CS = [1,0,0,1]
                    elif j == 10:
                        CS = [1,0,1,0]        
                    elif j == 11:
                        CS = [1,0,1,1]    
                    elif j == 12:
                        CS = [1,1,0,0]
                    elif j == 13:
                        CS = [1,1,0,1]        
                    elif j == 14:
                        CS = [1,1,1,0]    
                    elif j == 15:
                        CS = [1,1,1,1]  
                    ExpectedValue = 0    
                    for x in range(4):
                        for y in range(4):
                            prob = 1/16           
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
            col = [{"col":"FFFF"}, {"col":"FFFC"}, {"col":"FFCF"}, {"col":"FFCC"}, {"col":"FCFF"}, {"col":"FCFC"}, {"col":"FCCF"}, {"col":"FCCC"},
            {"col":"CFFF"}, {"col":"CFFC"}, {"col":"CFCF"}, {"col":"CFCC"}, {"col":"CCFF"}, {"col":"CCFC"}, {"col":"CCCF"}, {"col":"CCCC"}, ]

            for i in range(16):
                C.append({"c":"c"})

            for i in range(16):
                data2 = []
                for j in range(16):
                    data2.append({"entry":A[i][j]})
                if i == 0:    
                    data.append({"row": "FFFF", "data2":data2})   
                if i == 1:    
                    data.append({"row": "FFFR", "data2":data2})       
                if i == 2:    
                    data.append({"row": "FFRF", "data2":data2}) 
                if i == 3:    
                    data.append({"row": "FFRR", "data2":data2})
                if i == 4:    
                    data.append({"row": "FRFF", "data2":data2})
                if i == 5:    
                    data.append({"row": "FRFR", "data2":data2})
                if i == 6:    
                    data.append({"row": "FRRF", "data2":data2})
                if i == 7:    
                    data.append({"row": "FRRR", "data2":data2}) 
                if i == 8:    
                    data.append({"row": "RFFF", "data2":data2})   
                if i == 9:    
                    data.append({"row": "RFFR", "data2":data2})       
                if i == 10:    
                    data.append({"row": "RFRF", "data2":data2}) 
                if i == 11:    
                    data.append({"row": "RFRR", "data2":data2})
                if i == 12:    
                    data.append({"row": "RRFF", "data2":data2})
                if i == 13:    
                    data.append({"row": "RRFR", "data2":data2})
                if i == 14:    
                    data.append({"row": "RRRF", "data2":data2})
                if i == 15:    
                    data.append({"row": "RRRR", "data2":data2})                                                 




            return {
                scenario: True,
                "data": data,   
                "C": C,   
                "col": col,  
                "pool": pool,
                "bet": bet,     
                
            }   