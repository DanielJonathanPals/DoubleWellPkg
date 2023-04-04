using DoubleWellPkg
using Documenter

DocMeta.setdocmeta!(DoubleWellPkg, :DocTestSetup, :(using DoubleWellPkg); recursive=true)

makedocs(;
    modules=[DoubleWellPkg],
    authors="Daniel Pals <Daniel.Pals@tum.de>",
    repo="https://github.com/DanielJonathanPals/DoubleWellPkg.jl/blob/{commit}{path}#{line}",
    sitename="DoubleWellPkg.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
