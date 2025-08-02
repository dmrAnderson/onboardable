# CHANGELOG

## [Unreleased]

## [1.5.0] - 2025-08-01

- Drop support for Ruby 3.1.
- Update development dependencies to their latest versions.

## [1.4.0] - 2025-04-01

- Add support for Ruby 3.4.
- Drop support for Ruby 3.0.

## [1.3.3] - 2024-08-16

- Updated rbs files to improve type-checking.
- Added github-actions package ecosystem to the development workflow.

## [1.3.2] - 2024-07-10

- Added adjustments to rbs files to improve type-checking.

## [1.3.1] - 2024-06-10

- Fixed the issue with the custom formula calculation.

## [1.3.0] - 2024-06-10

- Added option to calculate onboarding progress using a custom formula.

## [1.2.2] - 2024-06-03

- Fixed the issue with the default `#current_step` method.

## [1.2.1] - 2024-06-01

- Added trusted publisher

## [1.2.0] - 2024-05-25

- Added `#second_step?` method to check if the target step is the second step.
- Added `#prev_step?` method to check if the target step is the previous step.
- Added `#current_step?` method to check if the target step is the current step.

## [1.1.1] - 2024-05-21

- Added `onboarding` class method to define the onboarding steps.
- Added [documentation link](https://rubydoc.info/gems/onboardable) to gemspec.

## [1.1.0] - 2024-05-21

- Introduced `step_from` method for adding steps from external sources.
- Added warn_about_override method to alert on step overrides.
- Added YARD documentation to the project for improved code documentation.

## [1.0.1] - 2024-05-09

- Added `first_step` and `last_step` methods to easily access
  the boundaries of step lists.
- Added `progress` method for calculating onboarding completion percentage.

## [1.0.0] - 2024-05-08

- Enhanced `first_step?` and `last_step?` methods to accept an optional argument,
  improving flexibility by allowing checks against any specified step.

## [0.1.0] - 2024-05-07

- Initial release
