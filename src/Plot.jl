using GLMakie

struct PlotObjects
    T_max::Number  #Runtime
    x_lims::Tuple
    y_lims::Tuple
    fig::Figure
    axis::Vector{Axis}
end

function PlotObjects(T_max::Number = 100, x_lims::Tuple = (-5,5), y_lims::Tuple = (-5,5))
    fig = Figure(; resolution=(1400, 500))

    ax_phase = Axis(fig[1:3, 1], title = "Phase space", xlabel = "x", ylabel = "deterministic force")
    xlims!(ax_phase,x_lims)
    ylims!(ax_phase,y_lims)

    ax_param = Axis(fig[1:2, 2], title = "Parameter values", xlabel = "t")
    xlims!(ax_param,(0,T_max))

    ax_obs = Axis(fig[3, 2], title = "Observable", xlabel = "t")
    xlims!(ax_obs,(0,T_max))

    return PlotObjects(T_max,x_lims,y_lims,fig,[ax_phase,ax_param,ax_obs])
end