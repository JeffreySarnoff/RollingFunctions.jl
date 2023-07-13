using Documenter

pushfirst!(LOAD_PATH, joinpath(@__DIR__, "..")) # add to environment stack

makedocs(
    # modules = [RollingFunctions],
    sitename = "RollingFunctions.jl",
    authors = "Jeffrey Sarnoff <jeffrey.sarnoff@gmail.com>",
    format=Documenter.HTML(
        canonical = "https://jeffreysarnoff.github.io/RollingFunctions.jl/stable/",
        prettyurls=!("local" in ARGS),
        highlights=["yaml"],
        ansicolor=true,
    ),
    pages = Any[
        "Home" => "index.md",
        "Approaches" => Any[
            "rolling" => "approach/rolling.md",
            "tiling"  => "approach/tiling.md",
            "running" => "approach/running.md",
            "datastreams" => "approach/datastreams.md"
        ],
        "Options" => Any[
            "padding"=>"approach/padding.md",
            "atend"=>"approach/atend.md",
            "weighting"=>"approach/weighted.md"
        ],
        "Examples of Use" => Any[
            "rolling" => "use/rolling.md",
            "tiling"=>"use/tiling.md",
            "running"=>"use/running.md",
        ],
        "Examples of Options"=>Any[
            "padding"=>"use/padding.md",
            "atend"=>"use/atend.md",
            "weights"=>"use/weights.md",
        ],
        "References" => "references.md",
        "Thanks" => "thanks.md"
    ]
)

deploydocs(
    repo = "github.com/JeffreySarnoff/RollingFunctions.jl.git",
    target = "build"
)
