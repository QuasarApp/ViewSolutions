# AGENTS.md

Working guidance for AI coding agents and developers in the `QuasarApp/ViewSolutions` repository.

## Description

ViewSolutions is the shared QML view layer of the QuasarApp project group:
reusable QML components (e.g. the animated `ImageView`, color picker,
models, avatar generator) consumed by QuasarApp applications — including
Ecliptica, which imports `ViewSolutionsModule` in its UI.

- **Language:** C++17 + Qt (Core, Quick, QuickControls2) + QML
- **Build system:** CMake ≥ 3.19 (typically with Ninja)
- **License:** LGPLv3

### Repository layout

| Path | Contents |
|---|---|
| `ViewSolutions/` | the `ViewSolutions` QML module library (`qt_add_library`) + `src/` C++ helpers (models, avatargenerator, colorpicker, …) + `assets/` |
| `Examples/` | example app (built with `VIEWSOLUTIONS_EXAMPLES=ON`) |
| `res/` | shared resources |
| `CMake/` | the QuasarApp CMake layer (`QuasarApp/CMake` submodule) |
| `Docs/`, `mkdocs.yml` | documentation (→ `quasarapp.github.io/ViewSolutions`) |

### Architecture

- One QML module library (`ViewSolutions`) plus a C++ side (models/helpers)
  registered into the module; consumers add `add_subdirectory(ViewSolutions)`
  and `import ViewSolutionsModule 1.0`.
- The QuasarApp CMake layer (`initAll()`) provides the `test` / `doc` /
  `deploy` / `release` targets.

## Developing process

### Toolchain

| Tool | Version / notes |
|---|---|
| CMake | ≥ 3.19 |
| Compiler | C++17 |
| Qt | 6.10 (CI docs pipeline aside, use the group standard 6.10.3), modules: Core, Quick, QuickControls2 |
| Ninja | preferred generator |
| CQtDeployer | `cqtdeployer` on `PATH` — required by the `deploy`/`release` targets |

### Build

Step by step.

**1. One-time toolchain setup.** Qt 6.10.3 via aqtinstall
(`aqt install-qt linux desktop 6.10.3 gcc_64 -O /opt/Qt`) plus CMake ≥ 3.19
and Ninja.

**2. Get the sources.** The CMake-layer submodule is mandatory:

```sh
git clone --recurse-submodules https://github.com/QuasarApp/ViewSolutions.git
# or, for an existing clone:
git submodule update --init --recursive
```

**3. Configure.**

```sh
cmake -B build -G Ninja \
  -DCMAKE_PREFIX_PATH=/opt/Qt/6.10.3/gcc_64 \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Debug
```

**4. Build.**

```sh
cmake --build build --parallel 16
```

**5. Find the result.** The deliverable is the `ViewSolutions` QML module
library, plus the example app (built with `VIEWSOLUTIONS_EXAMPLES=ON`,
default) — run the example on a desktop with a display to see the QML
components.

CMake options (top level):

- `VIEWSOLUTIONS_EXAMPLES` — build the examples (default `ON`; forced `OFF`
  on Android/iOS)
- `QT_QML_GENERATE_QMLLS_INI` — generate QML LSP support (default `ON`)

### Branching, labels and pull requests (workflow for AI agents)

- Work is issue-driven: one GitHub issue → one branch named
  `task_<issue-number>`, branched **strictly from `main`** — never from
  another task branch.
- Commit messages: short imperative subject + issue reference, e.g.
  `fix: <summary> (issue #<issue>)`, `docs: <summary> (issue #<issue>)`.
- Keep the build and lint green; a red CI blocks the merge.

**The exact commands.**

```sh
# 1. every task starts from a freshly fetched main
git fetch origin
git checkout -b task_<issue> origin/main

# 2. label the issue while working. Workflow labels in this repo:
#    in-progress, waiting-for-review, blocked, needs-clarification,
#    help wanted, question
gh issue edit <issue> --add-label in-progress

# 3. post the initial checklist as a comment; afterwards update that same
#    comment in place, never re-post it
gh issue comment <issue> --body-file /tmp/checklist.md
gh issue comment <issue> --edit-last --body-file /tmp/checklist.md

# 4. push and open the PR — see "Creating the pull request" below
git push -u origin task_<issue>
gh pr create --base main --head task_<issue> \
  --title "<type>: <short imperative summary> (issue #<issue>)" \
  --body-file /tmp/pr_body.md

# 5. the issue goes to waiting-for-review; watch CI from the CLI
gh issue edit <issue> --remove-label in-progress --add-label waiting-for-review
gh pr checks <number>
```

**Status messages — what to post and when.** An agent must keep a
human-readable trail on the issue (and on the PR once it exists). Every
message is a GitHub comment with a `##` heading; the checklist comment is
updated in place (`--edit-last`), never duplicated.

| Stage | Label(s) | Comment template |
|---|---|---|
| Start | `in-progress` | `## Task issue_XXX: <title> — initial checklist (branch task_XXX from main)` — one `- [ ]` line per sub-task |
| Each step done | — | edit the checklist comment: mark the line `- [x]` + one short evidence note (command run, result) |
| Blocked / needs input | `blocked` / `question` | `## Blocked — task_XXX` — what is blocking and exactly what is needed to continue |
| PR opened | `waiting-for-review` | `## Progress — task_XXX` — all lines `- [x]` + `**PR: <url>**` + one-line verification summary |
| Review changes requested | `waiting-for-review` | `## Review-fix cycle — PR #NNN — update` — one `- [x]` line per review point, each with the evidence |
| CI red on the PR | `in-progress` | `## CI failure — PR #NNN` — failing check, cause, fix plan; push the fix, then update the comment |

**Creating the pull request.** An agent has no browser and cannot create a
pull request from the GitHub web UI — it must use the `gh` CLI (a token with
the `repo` scope; in this organisation the agent runs as `QuasarAppCI`):

```sh
gh pr create \
  --base main \
  --head task_<issue> \
  --title "<type>: <short imperative summary> (issue #<issue>)" \
  --body-file /tmp/pr_body.md
```

- The body carries what changed and the verification actually performed
  (commands + their real output); `(issue #<n>)` in the title links the PR
  to the issue. Use `--draft` while still iterating.
- A pull request exists only when `gh pr create` prints its URL. Confirm
  with `gh pr view <number> --json number,url,mergeable` before reporting
  "PR created" — never post that status on faith.
- If work is blocked, keep the PR open, set the issue label to `blocked` and
  post the status message above.

### Documentation rules

- `Docs/` + `mkdocs.yml` publish the QML component reference to
  `quasarapp.github.io/ViewSolutions` — a component change and its docs
  ship in the same PR.
- A new QML component ships **with** an example in `Examples/` — never in a
  follow-up ticket.

## Testing process

### Test infrastructure

This repository has no unit-test suite: the QML components are exercised by
the consuming applications (Ecliptica) and by the `Examples/` app. The
`initAll()` call (QuasarApp CMake layer) still registers the standard `test`
aggregate target — it is **empty** here (no suite is registered via
`addTests`), so `cmake --build build --target test` is a no-op. The only CI
in the repo is `deploy-docs.yml` (publishes the documentation; it does not
build the code).

### Running the tests from CMake (via a consuming project)

There is nothing to run in this repository — verification of a change is a
build, and it runs from CMake: configure + build this repository (library +
examples), then build a consumer project against the changed module. The
natural consumer is Ecliptica, which builds the module in-tree
(`add_subdirectory(submodules/ViewSolutions)` — `Ecliptica/CMakeLists.txt:96`):

```sh
# 1. this repository: module + examples, green
cmake -B build -G Ninja -DCMAKE_PREFIX_PATH=/opt/Qt/6.10.3/gcc_64 \
  -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel 16

# 2. in a sibling Ecliptica clone: point the ViewSolutions submodule at
#    your branch, then configure + build the game. Ecliptica's full
#    toolchain applies (Qt 6.10.3 + Quick3D module set, SDL3, Vulkan — see
#    Ecliptica/AGENTS.md); the SDL3 root (the directory containing
#    include/SDL3 and lib/cmake/SDL3) goes on CMAKE_PREFIX_PATH as well
git -C submodules/ViewSolutions fetch origin <task-branch>
git -C submodules/ViewSolutions checkout <task-branch>
cmake -B build -G Ninja \
  -DCMAKE_PREFIX_PATH=/opt/Qt/6.10.3/gcc_64;<SDL3-root> \
  -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel 16
```

### Smoke tests — the most important testing step

The smoke test is the most important testing step of this project: a fast,
headless, CMake-runnable proof that the changed module still builds — both
standalone and inside its consumer. No display is needed at any point:

1. Configure + build **this repository** green (Debug): the `ViewSolutions`
   module and the `ViewSolutionsExamples` app.
2. Build the **consumer (Ecliptica)** against the changed module (its
   `ViewSolutions` submodule pointed at your branch, as above).

A red build in either step is a smoke-test failure for this repository and
blocks the merge — because Ecliptica's UI imports `ViewSolutionsModule`, a
regression here is a regression in the game. The QML runtime behavior is an
extra, manual check on top of the smoke test: run the example app on a
display (see Build).