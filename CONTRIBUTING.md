# Contributing to Loot Table Editor

First off, thanks for considering contributing! We welcome all kinds of contributions: bug reports, feature requests, documentation improvements, or code enhancements.

---

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [How to Report a Bug](#how-to-report-a-bug)
3. [How to Request a Feature](#how-to-request-a-feature)
4. [Local Development Setup](#local-development-setup)
5. [Branching & Git Workflow](#branching--git-workflow)
6. [Coding Standards](#coding-standards)
7. [Submitting a Pull Request](#submitting-a-pull-request)
8. [Review Process](#review-process)
9. [Testing](#testing)
10. [Acknowledgements](#acknowledgements)

---

## Code of Conduct

This project follows the [Godot Engine Code of Conduct](https://godotengine.org/code-of-conduct). By participating, you agree to abide by its terms.

---

## How to Report a Bug

1. Check existing issues to see if it’s already reported.
2. Open a new issue and include:

   * A clear and descriptive title.
   * Steps to reproduce the problem.
   * Expected vs. actual behavior.
   * Godot version and OS.
   * Minimal reproduction project, if possible.

---

## How to Request a Feature

1. Search existing issues to avoid duplicates.
2. Open an issue labeled **enhancement** and describe:

   * Use case and motivation.
   * Example code snippets or mockups.

---

## Local Development Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/loot_table_editor.git
   cd loot_table_editor
   ```
2. Open the project in Godot 4.4+.
3. Enable the plugin under **Project → Project Settings → Plugins**.
4. Make your changes in `addons/loot_table_editor/` or `scripts/loot_tables/`.

---

## Branching & Git Workflow

* Use the **main** branch for stable releases.
* Create feature branches named `feat/description` or bugfix branches `fix/description`.
* Keep commits focused and atomic.
* Write clear commit messages in the form:

  ```
  type(scope): short description

  optional body
  ```

  * **type**: feat, fix, docs, style, refactor, test, chore
  * **scope**: area of the plugin (e.g., `editor`, `runtime`)

---

## Coding Standards

* Follow the [Godot GDScript Style Guide](https://docs.godotengine.org/en/stable/community/contributing/styleguide/gdscript_styleguide.html).
* Use **snake\_case** for functions, variables, and files.
* Keep functions short (max \~50 lines).
* Write names that describe intent; avoid redundant comments.
* Ensure `@tool` scripts only run in the editor context.

---

## Submitting a Pull Request

1. Fork the repo and create your branch.
2. Commit your changes and push to your fork.
3. Open a pull request against **main**.
4. In the PR description, reference related issues and summarize your changes.
5. Please be clear and descriptive in your PR description as it may save review time and questions.

---

## Review Process

* PRs will be reviewed by the maintainer(s).
* You may be asked to adjust code style, add tests, or refine documentation.
* Once approved, a maintainer will merge and tag a release.

---

## Testing

* No automated tests yet; manual testing steps:

  1. Load the plugin in Godot 4.4.
  2. Create or open a `LootTableDatabase`.
  3. Add/remove tables and entries, adjust amount/weight, and verify persistence.

* Test cases are planned and will be added depending on the requests, feel free to add yours.

---

## Acknowledgements

Thanks to all contributors and the Godot community for inspiration and support.
