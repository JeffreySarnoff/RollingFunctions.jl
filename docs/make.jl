using Documenter

makedocs(
    # modules = [RollingFunctions], (requires use of @doc in source comments)
    sitename = "RollingFunctions",
    authors = "Jeffrey A. Sarnoff and other contributors",
    source="src",
    clean=false,
    strict=!("strict=false" in ARGS),
    doctest=("doctest=only" in ARGS) ? :only : true,
    format=Documenter.HTML(
        # Use clean URLs, unless built as a "local" build
        prettyurls=!("local" in ARGS),
        highlights=["yaml"],
        ansicolor=true,
    ),
    pages=[
        "Home" => "index.md",
        "Overview" => "overview.md",
        "Introduction" => Any[
            "Windowed Data"=>"intro/windoweddata.md",
            "Running over Windows"=>"intro/running.md",
            "Rolling over Windows"=>"intro/rolling.md",
            "Stepping over Data"=>"intro/stepping.md",
        ],
        "API" => Any[
            "roll" => "api/roll.md",
            "run" => "api/run.md",
        ],
        "Technical Reference" => Any[
            "window structs" => "tech/windows.md",
            "window sorts" => "tech/windowsorts.md",
            "function arity" => "tech/arity.md",
        ],
        "References" => "references.md",
    ]
)

#=
Deploy docs to Github pages.
=#
Documenter.deploydocs(
    branch = "gh-pages",
    target = "build",
    deps = nothing,
    make = nothing,
    repo = "github.com/JeffreySarnoff/RollingFunctions.jl.git",
)

