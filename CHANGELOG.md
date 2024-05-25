# CHANGELOG

## [Unreleased]

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
