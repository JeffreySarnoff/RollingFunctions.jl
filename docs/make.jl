using Documenter # , ArbNumerics

makedocs(
    sitename = "RollingFunctions.jl",
    authors = "Jeffrey Sarnoff and other contributors",
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
            "windowing math" => "tech/windowmath.md",
            "function arity" => "tech/arity.md",
        ],
        "References" => "references.md",
    ]
)

deploydocs(
    repo = "github.com/JeffreySarnoff/RollingFunctions.jl.git",
    target = "build"
)
