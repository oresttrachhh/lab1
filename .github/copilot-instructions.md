# Project Guidelines

## Architecture

- This repository root is the Maven project; use the standard `src/main/java`
  and `src/test/java` layout. The main package is
  `com.example.helloproject`.
- `pom.xml` targets Java 17, uses JUnit Jupiter 5.11.0, writes Maven output
  to `build/`, and produces the executable `build/hello.jar` with
  `com.example.helloproject.HelloProject` as its main class.
- `HelloProject` provides the executable greeting, while `BasicAddition`
  demonstrates a small independently tested domain function. Keep production
  code and its JUnit tests in the matching package.
- Local and CI verification is intentionally centralized in `ci.bat` and
  `ci.sh`. The GitHub Actions workflow only prepares Java and delegates to
  those scripts: Windows runs `.\ci.bat`; Linux and macOS run `bash ./ci.sh`.
  Do not move Maven commands directly into `.github/workflows/ci.yml`.
- The `.github/agents`, `.github/skills`, and `.github/prompts` files describe
  the Build Engineer Agent and its idempotent project-setup workflow. Follow
  the detailed behavior in [docs/architecture.md](../docs/architecture.md)
  when changing those customizations.

## Build and Test

Prerequisites are JDK 17+ and Maven 3.9+.

- Run the full unit-test suite:
  `mvn --batch-mode test`
- Run one test class:
  `mvn --batch-mode -Dtest=HelloProjectTest test`
- Run one test method:
  `mvn --batch-mode -Dtest=HelloProjectTest#greetingReturnsHelloWorld test`
- Build the executable JAR:
  `mvn --batch-mode package`
- Run the complete platform-specific verification:
  - Windows: `.\ci.bat`
  - Linux/macOS: `bash ./ci.sh`
- Verify the packaged application directly:
  `java -jar build/hello.jar`

The CI scripts run `clean test`, `package`, verify that `build/hello.jar`
exists, and execute the JAR. They return a non-zero status on failure; keep
that behavior intact.

There is no repository-specific lint command or lint configuration. For
workflow changes, validate the YAML and run the relevant CI script when the
local operating system supports it.

## Conventions

- Preserve the existing Maven coordinates and Java release unless the task
  explicitly changes the project contract.
- Use JUnit 5 (`org.junit.jupiter.api.Test` and Jupiter assertions) and place
  tests under `src/test/java` with the same package as the class under test.
- Keep the generated artifact name and location as `build/hello.jar`; the
  `.gitignore` excludes generated build output.
- CI is a three-OS matrix (`windows-latest`, `ubuntu-latest`,
  `macos-latest`) for `push` and `pull_request` targeting `main`, `develop`,
  or `master`. Preserve the platform-specific script conditions and the
  workflow's read-only contents permission.
- Build Engineer Agent operations are repository-root scoped. Before editing
  an existing file, inspect it and preserve unrelated user changes. Prefer
  `REUSE`, `CREATE`, `UPDATE`, or `SKIP` behavior over overwriting correct
  files; do not duplicate dependencies, plugins, tests, jobs, triggers, or
  workflows.
- Report actual command failures and their causes. Do not mask build, test, or
  CI failures with fallback success or `continue-on-error`.
- The agent's documented workflow and user-facing explanations are Ukrainian;
  preserve that language when modifying the agent, skills, or prompt commands.

See [README.md](../README.md) for project usage,
[docs/usage.md](../docs/usage.md) for exact commands, and
[docs/architecture.md](../docs/architecture.md) for the full agent workflow.
