# AGENTS.md

Working guidance for AI coding agents and developers in the `QuasarApp/ViewSolutions` repository.

## Description

ViewSolutions is the shared QML view layer of the QuasarApp project group:
reusable QML components (the animated `ImageView`, color picker, models,
avatar generator) consumed by QuasarApp applications.

- **Language:** C++17 + Qt (Core, Quick, QuickControls2) + QML
- **Build system:** CMake ≥ 3.19 (typically with Ninja)
- **License:** LGPLv3

### Repository layout

| Path | Contents |
|---|---|
| `ViewSolutions/` | the `ViewSolutions` QML module library + `src/` C++ helpers (models, avatargenerator, colorpicker) + `assets/` |
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
| Qt | 6.10.3 (Core, Quick, QuickControls2) |
| Ninja | preferred generator |
| CQtDeployer | `cqtdeployer` on `PATH`, required by the `deploy`/`release` targets |

### Build

One-time: `aqt install-qt linux desktop 6.10.3 gcc_64 -O /opt/Qt`, plus
CMake ≥ 3.19 and Ninja. Get the sources — the `CMake/` submodule is
mandatory; for an existing clone run `git submodule update --init --recursive`:

```sh
git clone --recurse-submodules https://github.com/QuasarApp/ViewSolutions.git
cmake -B build -G Ninja \
  -DCMAKE_PREFIX_PATH=/opt/Qt/6.10.3/gcc_64 \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel 16
```

The deliverable is the `ViewSolutions` QML module library; the example app
(`VIEWSOLUTIONS_EXAMPLES=ON`, default) is built alongside it — run it on a
desktop with a display to see the components.

CMake options (top level):

- `VIEWSOLUTIONS_EXAMPLES` — build the examples (default `ON`; forced `OFF` on Android/iOS)
- `QT_QML_GENERATE_QMLLS_INI` — generate QML LSP support (default `ON`)

### Branching, labels and pull requests (workflow for AI agents)

Work is issue-driven: one issue → one branch `task_<issue>`, cut **strictly
from `main`**, never from another task branch. Commit messages: short
imperative subject + issue reference — `docs: <summary> (issue #<issue>)`.
Keep the build green; a red CI blocks the merge.

```sh
git fetch origin
git checkout -b task_<issue> origin/main
gh issue edit <issue> --add-label in-progress
gh issue comment <issue> --body-file /tmp/checklist.md
git push -u origin task_<issue>
gh pr create --base main --head task_<issue> \
  --title "<type>: <summary> (issue #<issue>)" \
  --body-file /tmp/pr_body.md
gh issue edit <issue> --remove-label in-progress --add-label waiting-for-review
gh pr checks <number>
```

Workflow labels: `in-progress`, `waiting-for-review`, `blocked`,
`needs-clarification`, `help wanted`, `question`.

Keep one checklist comment on the issue, updated in place
(`gh issue comment <issue> --edit-last --body-file /tmp/checklist.md`), never
re-posted. Every status message is a comment with a `##` heading:

| Stage | Label(s) | Comment template |
|---|---|---|
| Start | `in-progress` | `## Task issue_XXX: <title> — initial checklist` — one `- [ ]` line per sub-task |
| Step done | — | edit the checklist: `- [x]` + a short evidence note (command, result) |
| Blocked / needs input | `blocked` / `question` | `## Blocked — task_XXX` — what blocks and exactly what is needed |
| PR opened | `waiting-for-review` | `## Progress — task_XXX` — all `- [x]` + `**PR: <url>**` + one-line verification |
| Review changes requested | `waiting-for-review` | `## Review-fix cycle — PR #NNN — update` — one `- [x]` line per review point |
| CI red on the PR | `in-progress` | `## CI failure — PR #NNN` — failing check, cause, fix plan |

A pull request is created with the `gh` CLI only (an agent has no browser; the
token needs the `repo` scope). The body carries what changed and the
verification actually performed (commands + their real output); use `--draft`
while iterating. A PR exists only when `gh pr create` prints its URL — confirm
with `gh pr view <number> --json number,url,mergeable` before reporting it.

### Documentation rules

- `Docs/` + `mkdocs.yml` publish the QML reference to
  `quasarapp.github.io/ViewSolutions` — a component change and its docs ship
  in the same PR.
- A new QML component ships **with** an example in `Examples/`, never in a
  follow-up ticket.

## Testing process

This repository has no unit-test suite: `initAll()` (QuasarApp CMake layer)
registers the standard `test` aggregate target, but it is **empty** here
(nothing is registered via `addTests`), so `cmake --build build --target test`
is a no-op. The only CI is `deploy-docs.yml` — it publishes the documentation
and does not build the code.

Verification of a change is a build that runs from CMake; configure + build of
this repository (module + examples) must stay green:

```sh
cmake -B build -G Ninja \
  -DCMAKE_PREFIX_PATH=/opt/Qt/6.10.3/gcc_64 \
  -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel 16
```
