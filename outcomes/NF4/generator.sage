class Generator(BaseGenerator):
    def data(self):
        var("s,d")
        
        dummy = 0
        maxflow = 0
        
        while dummy == 0 or maxflow < 10:
            cs1 = randrange(1,16)
            cs2 = randrange(1,16)
            c4d = randrange(1,16)     
            c3d = randrange(1,16)

            c12 = randrange(0,10)
            c21 = randrange(0,10)
            c43 = randrange(0,10)
            c34 = randrange(0,10)

            c13 = randrange(1,15)
            c31 = randrange(1,15)
            c14 = randrange(1,15)
            c41 = randrange(1,15)
            c23 = randrange(1,15)
            c32 = randrange(1,15)
            c24 = randrange(1,15)
            c42 = randrange(1,15)

            P = MixedIntegerLinearProgram()
            x = P.new_variable(integer=False, nonnegative=True)
            OBJ = x[3,d]+x[4,d]
            P.set_objective(OBJ)

            P.add_constraint(x[s,1] <= cs1)
            P.add_constraint(x[s,2] <= cs2)
            P.add_constraint(x[1,2] <= c12)
            P.add_constraint(x[2,1] <= c21)
            P.add_constraint(x[1,3] <= c13)
            P.add_constraint(x[3,1] <= c31)
            P.add_constraint(x[1,4] <= c14)
            P.add_constraint(x[4,1] <= c41)
            P.add_constraint(x[2,3] <= c23)
            P.add_constraint(x[3,2] <= c32)
            P.add_constraint(x[2,4] <= c24)
            P.add_constraint(x[4,2] <= c42)
            P.add_constraint(x[3,4] <= c34)
            P.add_constraint(x[4,3] <= c43)
            P.add_constraint(x[3,d] <= c3d)
            P.add_constraint(x[4,d] <= c4d)

            P.add_constraint(x[s,1]+x[2,1]+x[3,1]+x[4,1]-x[1,3]-x[1,4]-x[1,2] == 0)
            P.add_constraint(x[s,2]+x[1,2]+x[3,2]+x[4,2]-x[2,3]-x[2,4]-x[2,1] == 0)
            P.add_constraint(x[2,3]+x[1,3]+x[4,3]-x[3,1]-x[3,4]-x[3,2]-x[3,d] == 0)
            P.add_constraint(x[2,4]+x[1,4]+x[3,4]-x[4,3]-x[4,1]-x[4,2]-x[4,d] == 0)
            
            maxflow = P.solve()
            dummy = max([P.get_values(x[3,1]), P.get_values(x[4,1]), P.get_values(x[3,2]), P.get_values(x[4,2])])
        
        ws1 = randrange(1,5)
        ws2 = randrange(1,5)
        w4d = randrange(1,5)     
        w3d = randrange(1,5)

        w12 = randrange(1,5)
        w21 = randrange(1,5)
        w43 = randrange(1,5)
        w34 = randrange(1,5)

        w13 = randrange(1,5)
        w31 = randrange(1,5)
        w14 = randrange(1,5)
        w41 = randrange(1,5)
        w23 = randrange(1,5)
        w32 = randrange(1,5)
        w24 = randrange(1,5)
        w42 = randrange(1,5)
        
        flow = randrange(5, Rational(maxflow))
        D = MixedIntegerLinearProgram()
        z = D.new_variable(integer=False, nonnegative=True)
        OBJ = -1*(ws1*z[s,1] + ws2*z[s,2] + w12*z[1,2]+w21*z[2,1]+w13*z[1,3]+w31*z[3,1]+w14*z[1,4]+w41*z[4,1]+w23*z[2,3]+w32*z[3,2]+w24*z[2,4]+w42*z[4,2]+w34*z[3,4]+w43*z[4,3]+w3d*z[3,d]+w4d*z[4,d])
        D.set_objective(OBJ)
        D.add_constraint(z[3,d]+z[4,d] == flow)    
        D.add_constraint(z[s,1] <= cs1)
        D.add_constraint(z[s,2] <= cs2)
        D.add_constraint(z[1,2] <= c12)
        D.add_constraint(z[2,1] <= c21)
        D.add_constraint(z[1,3] <= c13)
        D.add_constraint(z[3,1] <= c31)
        D.add_constraint(z[1,4] <= c14)
        D.add_constraint(z[4,1] <= c41)
        D.add_constraint(z[2,3] <= c23)
        D.add_constraint(z[3,2] <= c32)
        D.add_constraint(z[2,4] <= c24)
        D.add_constraint(z[4,2] <= c42)
        D.add_constraint(z[3,4] <= c34)
        D.add_constraint(z[4,3] <= c43)
        D.add_constraint(z[3,d] <= c3d)
        D.add_constraint(z[4,d] <= c4d)

        D.add_constraint(z[s,1]+z[2,1]+z[3,1]+z[4,1]-z[1,3]-z[1,4]-z[1,2] == 0)
        D.add_constraint(z[s,2]+z[1,2]+z[3,2]+z[4,2]-z[2,3]-z[2,4]-z[2,1] == 0)
        D.add_constraint(z[2,3]+z[1,3]+z[4,3]-z[3,1]-z[3,4]-z[3,2]-z[3,d] == 0)
        D.add_constraint(z[2,4]+z[1,4]+z[3,4]-z[4,3]-z[4,1]-z[4,2]-z[4,d] == 0)

        optimalsolution = -1*D.solve()





        return {
            "cs1": cs1,
            "cs2": cs2,
            "c12": c12,
            "c21": c21,
            "c13": c13,
            "c31": c31,
            "c14": c14,
            "c41": c41,
            "c23": c23,
            "c32": c32,
            "c42": c42,
            "c24": c24,
            "c34": c34,
            "c43": c43,
            "c3d": c3d,
            "c4d": c4d,
            "ws1": ws1,
            "ws2": ws2,
            "w12": w12,
            "w21": w21,
            "w13": w13,
            "w31": w31,
            "w14": w14,
            "w41": w41,
            "w23": w23,
            "w32": w32,
            "w42": w42,
            "w24": w24,
            "w34": w34,
            "w43": w43,
            "w3d": w3d,
            "w4d": w4d,
            "zs1": D.get_values(z[s,1]),
            "zs2": D.get_values(z[s,2]),
            "z12": D.get_values(z[1,2]),
            "z21": D.get_values(z[2,1]),
            "z13": D.get_values(z[1,3]),
            "z31": D.get_values(z[3,1]),
            "z14": D.get_values(z[1,4]),
            "z41": D.get_values(z[4,1]),
            "z23": D.get_values(z[2,3]),
            "z32": D.get_values(z[3,2]),
            "z24": D.get_values(z[2,4]),
            "z42": D.get_values(z[4,2]),
            "z34": D.get_values(z[3,4]),
            "z43": D.get_values(z[4,3]),
            "z3d": D.get_values(z[3,d]),
            "z4d": D.get_values(z[4,d]),
            "optimalsolution": -1*D.solve(),
            "flow": flow,
        }

    
    @provide_data
    def graphics(data):
        # updated by clontz
        vsp = circle((0,0), 0.1, fill=True, edgecolor='blue', facecolor='blue', axes=False)
        v1p = circle((1,0.75), 0.1, fill=True, edgecolor='blue', facecolor='blue', axes=False)
        v2p = circle((1,-0.75), 0.1, fill=True, edgecolor='blue', facecolor='blue', axes=False)
        v3p = circle((2.5,0.75), 0.1, fill=True, edgecolor='blue', facecolor='blue', axes=False)
        v4p = circle((2.5,-0.75), 0.1, fill=True, edgecolor='blue', facecolor='blue', axes=False)
        vdp = circle((3.5,0), 0.1, fill=True, edgecolor='blue', facecolor='blue', axes=False)

        vsl = text("$ v_s$",(0.0-0.15,0), )
        v1l = text("$ v_1$",(1,0.75+0.15), )
        v2l = text("$ v_2$",(1,-0.75-0.15), )
        v3l = text("$ v_3$",(2.5,0.75+0.15), )
        v4l = text("$ v_4$",(2.5,-0.75-0.15), )
        vdl = text("$ v_d$",(3.5+0.15,0), )



        es1p = arrow2d((0,0.05), (1*0.95,0.75*0.95+0.05), color='black')
        es2p = arrow2d((0,0-0.05), (1*0.95,-0.75*0.95-0.05), color='black')
        e12p = arrow2d((1.05,0.75), (1.05,-0.75*0.95), color='black')
        e21p = arrow2d((0.95,-0.75), (0.95,0.75*0.95), color='black')
        e13p = arrow2d((1,0.8), (2.5*0.975,0.8), color='black')
        e31p = arrow2d((2.5,0.7), (1.05,0.7), color='black')
        e24p = arrow2d((1,-0.8), (2.5*0.975,-0.8), color='black')
        e42p = arrow2d((2.5,-0.7), (1.05,-0.7), color='black')
        e14p = arrow2d((1,0.75+0.075), (2.5*0.975,-0.75*0.975+0.075), color='black')
        e41p = arrow2d( (2.5,-0.75-0.075), (1*1.05,0.75*0.975-0.075), color='black')
        e23p = arrow2d((1,-1*(0.75+0.075)), (2.5*0.975,-1*(-0.75*0.975+0.075)), color='black')
        e32p = arrow2d( (2.5,-1*(-0.75-0.075)), (1*1.05,-1*(0.75*0.975-0.075)), color='black')
        e34p = arrow2d((2.55,0.75), (2.55,-0.75*0.95), color='black')
        e43p = arrow2d((2.45,-0.75), (2.45,0.75*0.95), color='black')
        e3dp = arrow2d((2.5,0.75), (3.5,0.025), color='black')
        e4dp = arrow2d((2.5,-0.75), (3.5,-0.025), color='black')

        es1l = text((data['cs1'], data['ws1']),(0.45,0.55), color='black')
        es2l = text((data['cs2'],data['ws2']),(0.45,-0.55), color='black')
        e12l = text((data['c12'], data['w12']),(1.2,0.1), color='black')
        e21l = text((data['c21'], data['w21']),(0.8,-0.1), color='black')
        e34l = text((data['c34'], data['w34']),(2.7,0.1), color='black')
        e43l = text((data['c43'], data['w43']),(2.3,-0.1), color='black')
        e13l = text((data['c13'], data['w13']),(1.75,0.85), color='black')
        e31l = text((data['c31'], data['w31']),(1.75,0.65), color='black')
        e24l = text((data['c24'], data['w24']),(1.75,-0.85), color='black')
        e42l = text((data['c42'], data['w42']),(1.75,-0.65), color='black')
        e13l = text((data['c13'], data['w13']),(1.75,0.85), color='black')
        e31l = text((data['c31'], data['w31']),(1.75,0.65), color='black')
        e14l = text((data['c14'], data['w14']),(1.45,0.45), color='black')
        e41l = text((data['c41'], data['w41']),(1.35,0.25), color='black')
        e23l = text((data['c23'], data['w23']),(1.45,-0.45), color='black')
        e32l = text((data['c32'], data['w32']),(1.35,-0.25), color='black')
        e3dl = text((data['c3d'], data['w3d']),(3,0.55), color='black')
        e4dl = text((data['c4d'], data['w4d']),(3,-0.55), color='black')

        plot = vsp+v1p+v2p+v3p+v4p+vdp+es1p+es2p+e12p+e21p+e13p+e31p+e24p+e42p+e14p+e41p+e23p+e32p+e34p+e43p+e3dp+e4dp
        plot = plot+es1l+es2l+e12l+e21l+e34l+e43l+e13l+e31l+e42l+e24l+e14l+e41l+e23l+e32l+e3dl+e4dl
        plot = plot+vsl+v1l+v2l+v3l+v4l+vdl
        



        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"Poly": Poly,
                "plot": plot,
               }
