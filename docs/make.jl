using Documenter, Geotherm

makedocs(;
    modules=[Geotherm],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/singularitti/Geotherm.jl/blob/{commit}{path}#L{line}",
    sitename="Geotherm.jl",
    authors="Qi Zhang <singularitti@outlook.com>",
    assets=String[],
)

deploydocs(;
    repo="github.com/singularitti/Geotherm.jl",
)
