class Generator(BaseGenerator):
    def data(self):
        var("x y")
        P = [0,0,0,0,0]
        f = [0,0,0,0,0]

        P[0] = [0,0]
        P[1] = [0, randrange(3,7)]
        P[2] = [randrange(2,6), P[1][1]+randrange(2,6)]
        P[3] = [P[2][0]+randrange(1,5), randrange(2,P[2][1]-1)]
        P[4] = [randrange(1,P[3][0]-1), 0]

        maxX = max([P[0][0], P[1][0], P[2][0], P[3][0], P[4][0], ])
        maxY = max([P[0][1], P[1][1], P[2][1], P[3][1], P[4][1], ])
        dummy = 0

        while dummy == 0:
            dummy = 1
            c1 = randrange(-5,6)
            c2 = randrange(-5,6)
            for i in range(5):
                f[i] = c1*P[i][0] + c2*P[i][1]
            for i in range(5):
                for j in range(5):
                    if i!=j and f[i]==f[j]:
                        dummy = 0
                        

        F = max(f)

        for i in range(5):
            if F == f[i]:
                X = P[i]

        a11 = P[1][1] - P[2][1]
        a12 = P[2][0] - P[1][0]
        d1 = gcd(a11, a12)
        a11 = a11/d1
        a12 = a12/d1
        b1 = a11*P[1][0] +   a12*P[1][1]
        if b1 < 0:
            b1 = -1*b1
            a11 = -1*a11
            a12 = -1*a12

        a21 = P[2][1] - P[3][1]
        a22 = P[3][0] - P[2][0]
        d2 = gcd(a21, a22)
        a21 = a21/d2
        a22 = a22/d2
        b2 = a21*P[2][0] +   a22*P[2][1]
        if b2 < 0:
            a21 = -1*a21
            a22 = -1*a22
            b2 = -1*b2

        a31 = P[3][1] - P[4][1]
        a32 = P[4][0] - P[3][0]
        d3 = gcd(a31, a32)
        a31 = a31/d3
        a32 = a32/d3
        b3 = a31*P[3][0] +   a32*P[3][1]
        if b3 < 0:
            a31 = -1*a31
            a32 = -1*a32
            b3 = -1*b3        

        

        return {
            "c1": c1,
            "c2": c2,
            "point": (X[0],X[1]),
            "soln": F,
            "P": P,
            "maxX": maxX,
            "maxY": maxY,
            "f": c1*x+c2*y,
            "A1": a11*x+a12*y,
            "A2": a21*x+a22*y,
            "A3": a31*x+a32*y,
            "b1": b1,
            "b2": b2,
            "b3": b3,
        }

    
    @provide_data
    def graphics(data):
        # updated by clontz
        var("x y")
        obj(x,y) = data['f'] - data['soln']
        Poly = polygon2d(data['P'], color="blue", alpha=0.7, edgecolor="black", thickness=1.5, axes=True, xmin = -2, xmax = data['maxX']+2, ymin = -2, ymax = data['maxY']+2)
        line = implicit_plot(obj, (x,-2,data['maxX']+2), (y,-2,data['maxY']+2), color="red", linestyle="dashed", frame=False, axes=True)
        endpoint = ( data['point'][0]+ data['c1']/(data['c1']**2+data['c2']**2)**(1/2), data['point'][1]+ data['c2']/(data['c1']**2+data['c2']**2)**(1/2))
        normal = arrow( data['point'], endpoint, color="purple" )



        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"Poly": Poly,
                "Line": Poly+line+normal,
               }
