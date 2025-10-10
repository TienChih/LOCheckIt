class Generator(BaseGenerator):
    def data(self):
        from sage.graphs.base.boost_graph import shortest_paths
        var("s,d")

        dummy = 4
        while dummy <= 4:
            cs1 = randrange(1,16)
            cs2 = randrange(1,16)
            c4d = randrange(1,16)     
            c3d = randrange(1,16)

            c12 = randrange(1,10)
            c21 = randrange(1,10)
            c43 = randrange(1,10)
            c34 = randrange(1,10)

            c13 = randrange(1,15)
            c14 = randrange(1,15)
            c23 = randrange(1,15)
            c24 = randrange(1,15)

            values = [randrange(1,6), randrange(1,6), randrange(1,6), randrange(0,6)]
            shuffle(values)
            c31 = values[0]
            c32 = values[1]
            c41 = values[2]
            c42 = values[3]

            G = DiGraph({ s: {1: cs1, 2:cs2}, 1: {2: c12, 3:c13, 4:c14}, 2: {1: c21, 3:c23, 4:c24}, 3: {1:c31, 2:c32, 4:c34, d:c3d}, 4: {1:c41, 2:c42, 3:c43, d:c4d}})

            D1 = G.distance(s, 1, by_weight=True)
            D2 = G.distance(s, 2, by_weight=True)
            D3 = G.distance(s, 3, by_weight=True)
            D4 = G.distance(s, 4, by_weight=True)
            Dd = G.distance(s, d, by_weight=True)
            dummy = len(G.shortest_path(s,d, by_weight=True,))

        
        
        
        
        ShortPath = []
        ShortPathv = G.shortest_path(s,d, by_weight=True)
        ShortPathv.remove(s)
        for i in ShortPathv:
            ShortPath.append({"i": i})
        
         
        
            

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
            "ShortPath": ShortPath,
            "D1": D1,
            "D2": D2,
            "D3": D3,
            "D4": D4,
            "Dd": Dd,
            
            
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

        es1l = text(data['cs1'],(0.45,0.45), color='black')
        es2l = text(data['cs2'],(0.45,-0.45), color='black')
        e12l = text(data['c12'],(1.1,0), color='black')
        e21l = text(data['c21'],(0.9,0), color='black')
        e34l = text(data['c34'],(2.6,0), color='black')
        e43l = text(data['c43'],(2.4,0), color='black')
        e13l = text(data['c13'],(1.75,0.85), color='black')
        e31l = text(data['c31'],(1.75,0.65), color='black')
        e24l = text(data['c24'],(1.75,-0.85), color='black')
        e42l = text(data['c42'],(1.75,-0.65), color='black')
        e13l = text(data['c13'],(1.75,0.85), color='black')
        e31l = text(data['c31'],(1.75,0.65), color='black')
        e14l = text(data['c14'],(1.45,0.45), color='black')
        e41l = text(data['c41'],(1.35,0.25), color='black')
        e23l = text(data['c23'],(1.45,-0.45), color='black')
        e32l = text(data['c32'],(1.35,-0.25), color='black')
        e3dl = text(data['c3d'],(3,0.45), color='black')
        e4dl = text(data['c4d'],(3,-0.45), color='black')

        vsd = text("0",(0.0-0.15,0), )
        v1d = text(data['D1'],(1,0.75+0.15), )
        v2d = text(data['D2'],(1,-0.75-0.15), )
        v3d = text(data['D3'],(2.5,0.75+0.15), )
        v4d = text(data['D4'],(2.5,-0.75-0.15), )
        vdd = text(data['Dd'],(3.5+0.15,0), )

        plot1 = vsp+v1p+v2p+v3p+v4p+vdp+es1p+es2p+e12p+e21p+e13p+e31p+e24p+e42p+e14p+e41p+e23p+e32p+e34p+e43p+e3dp+e4dp
        plot1 = plot1+es1l+es2l+e12l+e21l+e34l+e43l+e13l+e31l+e42l+e24l+e14l+e41l+e23l+e32l+e3dl+e4dl
        plot = plot1+vsl+v1l+v2l+v3l+v4l+vdl
        plot2 = plot1+vsd+v1d+v2d+v3d+v4d+vdd
        



        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"Poly": Poly,
                "plot": plot,
                "plot2": plot2,
               }
