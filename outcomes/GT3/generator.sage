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


        scenario = choice(["cards", "difference", "blotto", "evenodd"])

        if scenario == "cards":
            Suits = ["Hearts", "Spades", "Diamonds", "Clubs"]
            shuffle(Suits)
            Suit1 = Suits[0]
            Suit2 = Suits[1]

            Values = [2,3,4,5,6,7,8,9,10]
            S = Subsets(Values,8, submultiset=False)
            Pick = choice(S)

            Suitchoices = [Suit1, Suit2, Suit1, Suit2, ]
            shuffle(Suitchoices)
            SuitsR = [Suitchoices[i] for i in range(4)]
            shuffle(Suitchoices)
            SuitsC = [Suitchoices[i] for i in range(4)]

            cardR=[0,0,0,0]
            cardC=[0,0,0,0]

            for i in range(len(Pick)):
                if i%2 == 0:
                    cardR[(i-i%2)/2] = [Pick[i], SuitsR[(i-i%2)/2]]
                if i%2 == 1:
                    cardC[(i-i%2)/2] = [Pick[i], SuitsC[(i-i%2)/2]]   
            
            for i in range(len(cardR)):
                if cardR[i][1] == "Hearts":
                    cardR[i] = [cardR[i][0], cardR[i][1], "H"]
                if cardR[i][1] == "Spades":
                    cardR[i] = [cardR[i][0], cardR[i][1], "S"]    
                if cardR[i][1] == "Diamonds":
                    cardR[i] = [cardR[i][0], cardR[i][1], "D"]
                if cardR[i][1] == "Clubs":
                    cardR[i] = [cardR[i][0], cardR[i][1], "C"]   
                if cardC[i][1] == "Hearts":
                    cardC[i] = [cardC[i][0], cardC[i][1], "H"]
                if cardC[i][1] == "Spades":
                    cardC[i] = [cardC[i][0], cardC[i][1], "S"]    
                if cardC[i][1] == "Diamonds":
                    cardC[i] = [cardC[i][0], cardC[i][1], "D"]
                if cardC[i][1] == "Clubs":
                    cardC[i] = [cardC[i][0], cardC[i][1], "C"]            
                       
            A = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
            
            for i in range(4):
                for j in range(4):
                    print((i,j))
                    print(cardR[i])
                    if cardR[i][2] == cardC[j][2]:
                        A[i][j] = cardR[i][0] + cardC[j][0]
                    else:
                        A[i][j] = -1*cardR[i][0] - cardC[j][0]    
            
            return {
                scenario: True,
                "a11": A[0][0],
                "a12": A[0][1],
                "a13": A[0][2],
                "a14": A[0][3],
                "a21": A[1][0],
                "a22": A[1][1],
                "a23": A[1][2],
                "a24": A[1][3],
                "a31": A[2][0],
                "a32": A[2][1],
                "a33": A[2][2],
                "a34": A[2][3],
                "a41": A[3][0],
                "a42": A[3][1],
                "a43": A[3][2],
                "a44": A[3][3],
                "rn1": cardR[0][0],
                "rn2": cardR[1][0],
                "rn3": cardR[2][0],
                "rn4": cardR[3][0],
                "cn1": cardC[0][0],
                "cn2": cardC[1][0],
                "cn3": cardC[2][0],
                "cn4": cardC[3][0],
                "rs1": cardR[0][2],
                "rs2": cardR[1][2],
                "rs3": cardR[2][2],
                "rs4": cardR[3][2],
                "cs1": cardC[0][2],
                "cs2": cardC[1][2],
                "cs3": cardC[2][2],
                "cs4": cardC[3][2],   
                "rsuit1": cardR[0][1],
                "rsuit2": cardR[1][1],
                "rsuit3": cardR[2][1],
                "rsuit4": cardR[3][1],
                "csuit1": cardC[0][1],
                "csuit2": cardC[1][1],
                "csuit3": cardC[2][1],
                "csuit4": cardC[3][1],        
                
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