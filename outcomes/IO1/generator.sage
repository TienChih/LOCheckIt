class Generator(BaseGenerator):
    def data(self):
        var("x_1 x_2 x_3")
        
        dummy = True
        
        while dummy:
            a11 = randrange(1,6)
            a12 = randrange(1,6)
            a13 = randrange(1,6)

            A2 = [randrange(1,6)*choice([-1,1]), randrange(1,6), randrange(-5,6)]
            A3 = [randrange(1,6)*choice([-1,1]), randrange(1,6), randrange(-5,6)]

            shuffle(A2)
            shuffle(A3)

            a21 = A2[0]
            a22 = A2[1]
            a23 = A2[2]

            a31 = A3[0]
            a32 = A3[1]
            a33 = A3[2]

            b1 = randrange(5,31)
            b2 = randrange(5,31)
            b3 = randrange(5,31)

            C = [randrange(1,6)*choice([-1,1]), randrange(1,6), randrange(-5,6)]
            shuffle(C)

            c1 = C[0]
            c2 = C[1]
            c3 = C[2]

            d = 0


            P = MixedIntegerLinearProgram()
            x = P.new_variable(integer=False, nonnegative=True)
            OBJ = c1*x[1]+c2*x[2]+c3*x[3]
            P.set_objective(OBJ)

            P.add_constraint(a11*x[1]+a12*x[2]+a13*x[3] <= b1)
            P.add_constraint(a21*x[1]+a22*x[2]+a23*x[3] <= b2)
            P.add_constraint(a31*x[1]+a32*x[2]+a33*x[3] <= b3)
            
            optimalsolution = P.solve()
            count = 0
            if P.get_values(x[1]).is_integer():
                count +=1
            if P.get_values(x[2]).is_integer():
                count +=1    
            if P.get_values(x[3]).is_integer():
                count +=1    
            dummy = (count != 2)
        
        Q = MixedIntegerLinearProgram()
        y = Q.new_variable(integer=True, nonnegative=True)
        OBJI = c1*y[1]+c2*y[2]+c3*y[3]
        Q.set_objective(OBJI)

        Q.add_constraint(a11*y[1]+a12*y[2]+a13*y[3] <= b1)
        Q.add_constraint(a21*y[1]+a22*y[2]+a23*y[3] <= b2)
        Q.add_constraint(a31*y[1]+a32*y[2]+a33*y[3] <= b3)
            
        realoptimalsolution = Q.solve()
            
            
        return {
            "a11": a11,
            "a12": a12,
            "a13": a13,
            "a21": a21,
            "a22": a22,
            "a23": a23,
            "a31": a31,
            "a32": a32,
            "a33": a33,
            "b1": b1,
            "b2": b2,
            "b3": b3,
            "c1": c1,
            "c2": c2,
            "c3": c3,
            "objectivefunction": c1*x_1 + c2*x_2 + c3*x_3 - d,
            "row1": a11*x_1 + a12*x_2 + a13*x_3,
            "row2": a21*x_1 + a22*x_2 + a23*x_3,
            "row3": a31*x_1 + a32*x_2 + a33*x_3,
            "x1value": Q.get_values(y[1]),
            "x2value": Q.get_values(y[2]),
            "x3value": Q.get_values(y[3]),
            "optimalsolution": realoptimalsolution,
        }

    
    