using Geotherm
using Documenter

DocMeta.setdocmeta!(Geotherm, :DocTestSetup, :(using Geotherm); recursive=true)

makedocs(;
    modules=[Geotherm],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/MineralsCloud/Geotherm.jl/blob/{commit}{path}#{line}",
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
