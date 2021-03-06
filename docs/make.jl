using Geotherm
using Documenter

makedocs(;
    modules=[Geotherm],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/MineralsCloud/Geotherm.jl/blob/{commit}{path}#L{line}",
    sitename="Geotherm.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/Geotherm.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/Geotherm.jl",
)
