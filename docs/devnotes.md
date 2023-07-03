weight isa AbstractWeights
weights isa AbstractVector{<:AbstractVector}

weight2matrix(weight,ncolumns) = Base.stack(repeat([weight], ncolumns))


cd("C:\\Users\\MrJSa\\.julia\\projects\\RollingWindows.jl");
Pkg.activate(pwd());
Pkg.add(["DocumenterTools", "LiveServer"]);

using DocumenterTools, LiveServer;

servedocs()

#=
Open browser (127.0.0.1:8000)
http://localhost:8000/
CTRL+C to shut down liveserver
=#

#=
https://m3g.github.io/JuliaNotes.jl/stable/publish_docs/

How to deploy the documentation of a project

Visualize the Docs locally

```
julia> ] activate docs
julia> using LiveServer
julia> servedocs()
```
The docs will be rendered and hosted locally at the url provided in the output.

Use DocumenterTools to generate the keys

```
import DocumenterTools
DocumenterTools.genkeys()
```

Add the keys to the github repository

The first key, starting with ssh-rsa must be copied as a new "Deploy key` in the project, at:

Settings -> Deploy keys -> Add deploy key
(Be careful to allow Write permissions.)

The second key has to be copied to:

Settings -> Secrets -> Actions -> New repository secret
with the name DOCUMENTER_KEY.

---

Add the GithubActions (ci.yml) workflow file
Create, in your project, a file

/home/user/.julia/dev/Project/.github/workflows/ci.yml

with a content similar to THIS one. Change the package name.
```
name: CI
on:
  - push
  - pull_request
env:
  JULIA_NUM_THREADS: 2
jobs:
  test:
    name: Julia ${{ matrix.version }} - ${{ matrix.os }} - ${{ matrix.arch }} - ${{ github.event_name }}
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        version:
          - '1.6'
          - '^1.6'
        os:
          - ubuntu-latest
          - macOS-latest
          - windows-latest
        arch:
          - x64
    steps:
      - uses: actions/checkout@v3
      - uses: julia-actions/setup-julia@v1
        with:
          version: ${{ matrix.version }}
          arch: ${{ matrix.arch }}
          include-all-prereleases: true
      - uses: actions/cache@v3
        env:
          cache-name: cache-artifacts
        with:
          path: ~/.julia/artifacts
          key: ${{ runner.os }}-test-${{ env.cache-name }}-${{ hashFiles('**/Project.toml') }}
          restore-keys: |
            ${{ runner.os }}-test-${{ env.cache-name }}-
            ${{ runner.os }}-test-
            ${{ runner.os }}-
      - uses: julia-actions/julia-buildpkg@latest
      - uses: julia-actions/julia-runtest@latest
      - uses: julia-actions/julia-processcoverage@v1
      - uses: codecov/codecov-action@v3
        with:
          file: lcov.info
  docs:
    name: Documentation
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: julia-actions/setup-julia@v1
        with:
          version: '1'
      - run: |
          julia --project=docs -e '
            import Pkg; Pkg.add("Documenter")
            using Pkg
            Pkg.develop(PackageSpec(path=pwd()))
            Pkg.instantiate()'
      - run: |
          julia --project=docs -e '
            import Pkg; Pkg.add("Documenter")
            using Documenter: doctest
            using CellListMap
            doctest(CellListMap)'
      - run: julia --project=docs docs/make.jl
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          DOCUMENTER_KEY: ${{ secrets.DOCUMENTER_KEY }}
```


Go to the github page. Go to Releases 

Draft a new Release. 
Create a new tag for the new version (for example, v0.2.0) or 
a tag only for deploying the documentation (for example, v0.1.0+doc1). 
That will trigger the execution of the CI run and, hopefully, 
build the docs and the gh-branch that contain the docs automatically.

The pages will be hosted at, for example:

https://m3g.github.io/JuliaNotes.jl/stable/

You can also update the docs just by uploading a new tag, with:
git tag -a v0.1.0+doc2 -m "v0.1.0"
git push --tag

----

Create an empty gh-pages branch and choose it to deploy the page
I have seen these steps happening automatically after the tag is created. If not, follow the steps below.

Create a branch on the repository called gh-pages using:

git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Initializing gh-pages branch"
git push origin gh-pages
git checkout main

In the GitHub repository, do:

Settings -> GitHub Pages -> choose gh-pages (/root)

(that is, go to Settings, scroll down, on the GitHub pages section, 
 choose the gh-pages branch to deploy your page).

After the end of the CI run, if no error was detected, the site should be published.


----

For a registered package
In this case, you might want TagBot to tag and release automatically the documentation of new versions:

Create the TagBot.yml file
/home/user/.julia/dev/Project/.github/workflows/TagBot.yml

and add the content provided here: TagBot.yml example

```
name: TagBot
on:
  issue_comment:
    types:
      - created
  workflow_dispatch:
    inputs:
      lookback:
        default: 3
permissions:
  actions: read
  checks: read
  contents: write
  deployments: read
  issues: read
  discussions: read
  packages: read
  pages: read
  pull-requests: read
  repository-projects: read
  security-events: read
  statuses: read
jobs:
  TagBot:
    if: github.event_name == 'workflow_dispatch' || github.actor == 'JuliaTagBot'
    runs-on: ubuntu-latest
    steps:
      - uses: JuliaRegistries/TagBot@v1
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          # Edit the following line to reflect the actual name of the GitHub Secret containing your private key
          ssh: ${{ secrets.DOCUMENTER_KEY }}
          # ssh: ${{ secrets.NAME_OF_MY_SSH_PRIVATE_KEY_SECRET }}
```

