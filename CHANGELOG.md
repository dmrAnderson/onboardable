# CHANGELOG

## 1.7.1 (2026-10-25)

- Fix RBS signatures and type-check `lib/` with Steep.
- Package only `lib/`, `sig/`, `README.md`, `CHANGELOG.md` and `LICENSE.txt` in the gem.
- Fix README examples: `#next_step?` usage and the custom progress formula.
- Update README release steps for trusted publishing.
- Run tests before publishing the gem.
- Publish through the `release` environment and pin GitHub Actions to commit SHAs.
- Enforce 100% line and branch coverage.
- Update development dependencies to their latest versions.

## 1.7.0 (2026-05-12)

- Update Ruby version requirements to 3.3.
- Drop Ruby 3.2 from the CI matrix.
- Update development dependencies to their latest versions.

## 1.6.0 (2025-12-26)

- Add support for Ruby 4.0.

## 1.5.0 (2025-08-02)

- Drop support for Ruby 3.1.
- Update development dependencies to their latest versions.

## 1.4.0 (2025-04-01)

- Add support for Ruby 3.4.
- Drop support for Ruby 3.0.

## 1.3.3 (2024-08-15)

- Update RBS files to improve type-checking.
- Add the GitHub Actions package ecosystem to Dependabot.

## 1.3.2 (2024-07-09)

- Adjust RBS files to improve type-checking.

## 1.3.1 (2024-06-10)

- Fix the custom progress formula calculation.

## 1.3.0 (2024-06-10)

- Add an option to calculate onboarding progress using a custom formula.
- `has_onboarding` now accepts options and creates a new builder on each call,
  so repeated calls replace the steps instead of appending to them.
- `list_builder=` is now a plain setter and no longer takes a block.
- Add the public `onboarding=` class method; `has_onboarding` is now its alias.

## 1.2.2 (2024-06-03)

- Fix the default `#current_step` when no step name is given.

## 1.2.1 (2024-06-01)

- Add trusted publishing to the release workflow.
- **Breaking:** rename `List::Builder#build!` to `#build` and
  `#create_step_from!` to `#create_step_from` (no aliases kept).

## 1.2.0 (2024-05-25)

- Add `#next_step?` method to check if the target step is the next step.
- Add `#prev_step?` method to check if the target step is the previous step.
- Add `#current_step?` method to check if the target step is the current step.

## 1.1.1 (2024-05-21)

- Add `onboarding` class method that builds the onboarding list.
- Add [documentation link](https://rubydoc.info/gems/onboardable) to the gemspec.

## 1.1.0 (2024-05-21)

- Add `step_from` method for adding steps from external sources.
- Warn when a step with an existing name is overridden.
- Add YARD documentation.
- **Breaking:** rename `Onboardable::ListBuilder` to `Onboardable::List::Builder`
  and `Onboardable::List` to `Onboardable::List::Base`.
- **Breaking:** rename the public `ListBuilder#add_step` to `List::Builder#create_step`
  (the `step` DSL alias is unchanged).

## 1.0.1 (2024-05-09)

- Add `first_step` and `last_step` methods to access the boundaries of the step list.
- Add `progress` method for calculating the onboarding completion percentage.

## 1.0.0 (2024-05-08)

- `first_step?` and `last_step?` accept an optional step argument,
  allowing checks against any step.

## 0.1.0 (2024-05-07)

- Initial release.
