include("IntegrateTraj.jl")
include("Plot.jl")
include("System.jl")

"""
updater = RandomParamUpdate(DoubleWell,0.02)
objs = PlotObjects(DoubleWell; T_max = 1000)

p = runSimulation(objs,-1.,[-1.,1.,0.],updater;update_rate=100)
"""
updater = RandomParamUpdate(DoubleWell,0.2)
objs = PlotObjects(DoubleWell; T_max = 10)

runSimulation(objs,-1.,[-1.,1.,0.],updater;update_rate=1)
