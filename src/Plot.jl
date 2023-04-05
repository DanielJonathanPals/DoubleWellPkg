include("System.jl")
include("IntegrateTraj.jl")

using GLMakie


struct PlotObjects
    T_max::Number  #Runtime
    x_lims::Tuple
    y_lims::Tuple
    fig::Figure
    axis::Vector{Axis}
    sys::System
end


function PlotObjects(sys::System; T_max::Number = 100, x_lims::Tuple = (-5,5), y_lims::Tuple = (-5,5))
    fig = Figure(; resolution=(1400, 500))

    ax_phase = Axis(fig[1:3, 1], title = "Phase space", xlabel = "x", ylabel = "deterministic force")
    xlims!(ax_phase,x_lims)
    ylims!(ax_phase,y_lims)

    ax_param = Axis(fig[1:2, 2], title = "Parameter values", xlabel = "t")
    xlims!(ax_param,(0,T_max))

    ax_obs = Axis(fig[3, 2], title = "Observable", xlabel = "t")
    xlims!(ax_obs,(0,T_max))

    return PlotObjects(T_max,x_lims,y_lims,fig,[ax_phase,ax_param,ax_obs],sys)
end


function runSimulation(objs::PlotObjects,x₀::Number,p₀::Vector{Float64},updater::Updater;T_trans::Number=10, update_rate::Int=10)
    display(objs.fig)
    x_range = collect(range(objs.x_lims[1], objs.x_lims[2], 200))
    x = x₀
    p = p₀
    ylims!(objs.axis[2],(min(p₀...)-2,max(p₀...)+2))
    p_traj = [Observable(Point2f[Point2f(0,p₀[i])]) for i in 1:length(p₀)]
    for i in 1:length(p₀)
        lines!(objs.axis[2],p_traj[i])
    end
    force = lines!(objs.axis[1], x_range, [objs.sys.deterministic_forcing(i,p) for i in x_range], color = "grey")
    x_pos = scatter!(objs.axis[1],x,0, color = "black")
    for t in 0:objs.sys.dt:objs.T_max
        n = t/objs.sys.dt
        x,p = updater(x,p)
        if n % update_rate == 0
            for i in 1:length(p₀)
                push!(p_traj[i][],Point2f(t,p[i]))
                p_traj[i][] = p_traj[i][]
            end
            delete!(objs.axis[1], force)
            delete!(objs.axis[1], x_pos)
            force = lines!(objs.axis[1], x_range, [objs.sys.deterministic_forcing(i,p) for i in x_range], color = "grey")
            x_pos = scatter!(objs.axis[1],x,0, color = "black")
            sleep(0.001)
        end
    end
end