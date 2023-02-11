using Documenter, DocumenterTools

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
        "Overview" => "overview.md",
        "Introduction" => Any[
            "Rolling over Data (basics)" => "intro/rolling.md",
            "Rolling over Data (padding)" => "intro/padding.md",
            "Rolling over Data Matricies (basics)" => "intro/matrix_rolling.md",
            "Rolling over Data Matrices (padding)" => "intro/matrix_padding.md",
            "Rolling over multicolumn data (basics)" => "intro/multicolumn_rolling.md",
            "Rolling over multicolumn data (padding)" => "intro/multicolumn_padding.md",
           # "Windowed Data"=>"intro/windoweddata.md",
           # "Running over Windows"=>"intro/running.md",
           # "Stepping over Data"=>"intro/stepping.md",
        ],
        "API" => Any[
            "roll" => "api/roll.md",
            "run" => "api/run.md",
        ],
        "Technical Reference" => Any[
            "window structs" => "tech/windows.md",
            "window sorts" => "tech/windowsorts.md",
            "windowing math" => "tech/windowmath.md",
            "function arity" => "tech/arity.md",
        ],
        "References" => "references.md",
        "Thanks" => "thanks.md",
    ]
)

deploydocs(
    repo = "github.com/JeffreySarnoff/RollingFunctions.jl.git",
    target = "build"
)
