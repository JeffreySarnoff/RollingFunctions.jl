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
        "Use" => Any[
            "Rolling over windowed data" => "use/rolloverdata.md",
            "Rolling examples (basic)" => "use/rolling_examples.md",
            "Running over windowed data" => "use/runoverdata.md",
            "Running examples (basic)" => "use/running_examples.md",
        ],
        "Introduction" => Any[
            "Roll over vectors (padding)" => "intro/padding.md",
            "Roll over matricies (basics)" => "intro/matrix_rolling.md",
            "Roll over matrices (padding)" => "intro/matrix_padding.md",
            "Roll over multicolumn data (basics)" => "intro/multicolumn_rolling.md",
            "Roll over multicolumn data (padding)" => "intro/multicolumn_padding.md",
           # "Windowed Data"=>"intro/windoweddata.md",
           # "Running over Windows"=>"intro/running.md",
           # "Stepping over Data"=>"intro/stepping.md",
        ],
        "API" => Any[
            "roll" => "api/roll.md",
            "run" => "api/run.md",
        ],
        "Technical Reference" => Any[
            "windowing math" => "tech/windowmath.md",
        ],
        "References" => "references.md",
        "Thanks" => "thanks.md",
    ]
)

deploydocs(
    repo = "github.com/JeffreySarnoff/RollingFunctions.jl.git",
    target = "build"
)
