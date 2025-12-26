# 🚀 Onboardable

![Gem Version](https://img.shields.io/gem/v/onboardable)
![Build](https://img.shields.io/github/actions/workflow/status/dmrAnderson/onboardable/ci.yml)
![Code Coverage](https://img.shields.io/coverallsCoverage/github/dmrAnderson/onboardable)
![Gem Total Downloads](https://img.shields.io/gem/dt/onboardable)

The Onboardable gem is a Ruby module designed to simplify and streamline the
process of managing and navigating through a series of steps or stages within
an application, typically used for user onboarding workflows. By including
the Onboardable module in a class, developers can easily define a sequence
of onboarding steps, handle transitions between these steps, and maintain
the state of the current step in the sequence.

## 🔌 Installation

Install the gem and add to the application's Gemfile by executing:

```shell
bundle add onboardable
```

If the bundler is not being used to manage dependencies, install the gem by executing:

```shell
gem install onboardable
```

## ⚙️ Usage

First, ensure that the Onboardable gem is installed and properly set up in your
project as per the installation guide provided earlier.

### Defining Onboarding Steps

To incorporate an onboarding process into your `User` class, start by
including the `Onboardable` module to add onboarding functionality. Then,
define the onboarding steps with the `has_onboarding` method, detailing each
step with helpful tooltips and descriptions. Here's how you can set it up:

```ruby
class User
  include Onboardable

  has_onboarding do
    step 'welcome', message: 'Welcome to your new account!'
    step 'account_setup', task: 'Create credentials'
    step 'confirmation'
    step_from ExternalStepProvider
  end
end

class ExternalStepProvider
  def self.to_onboarding_step
    Onboardable::Step.new 'external_step', info: 'This is an external step.'
  end
end
```

### Using the Onboarding Steps

To enhance the guidance for users on how to navigate and manage the
onboarding flow using the Onboardable gem, here's a concise guide that
could be included in the documentation. This guide covers initialization,
navigation, step verification, and completion of the onboarding process.

After defining and accessing the onboarding steps as described
earlier, manage the onboarding process through various controls
that allow step navigation and state verification:

1. **Initialize Onboarding Process**

   - Instantiate the onboarding process when a `User` object is created.
     This sets up the initial step based on the defined onboarding flow.

     ```ruby
     onboarding = User.new.onboarding
     ```

   - For a more detailed setup, use the `Onboardable::List::Builder` to
     create a custom onboarding flow with specific steps and details.

     ```ruby
     builder = Onboardable::List::Builder.new

     builder.create_step 'welcome', message: 'Welcome to your new account!'
     builder.create_step 'account_setup', task: 'Create credentials'
     builder.create_step 'confirmation'
     builder.create_step_from ExternalStepProvider

     onboarding = builder.build
     ```

2. **Check the order of steps**

   Determine the order of steps in the onboarding process to ensure
   that the sequence is correct and that the steps are defined as expected.

   ```ruby
   onboarding.steps
   ```

3. **Navigating Through Steps**

   Navigate through the onboarding steps using the navigation methods provided.
   These methods help in moving forward and backward through the onboarding process.

   - **Next Step**

      Access the next step without changing the current step to preview
      what's next or advance to it, updating the current step status.

      ```ruby
      onboarding.next_step
      onboarding.next_step!
      ```

   - **Previous Step**

     Similarly, access the previous step to move back without
     making changes or updates to revert to the previous step.

     ```ruby
     onboarding.prev_step
     onboarding.prev_step!
     ```

4. **Check Step Position**

   Determine whether the current step is the first or the last in the sequence
   to manage UI elements like 'Next' or 'Back' buttons appropriately.

   ```ruby
   step = onboarding.steps.sample

   onboarding.first_step?(step)
   onboarding.last_step?(step)
   onboarding.current_step?(step)
   onboarding.second_step?(step)
   onboarding.prev_step?(step)
   ```

5. **Monitor Progress**

   - Calculate the progress or completion percentage of the onboarding process
     to provide users with an indication of how far they have progressed.

     ```ruby
     onboarding.progress
     ```

   - To customize the progress calculation formula, define a lambda function
     that takes the current step index and the total number of steps as arguments.

     ```ruby
     CALCULATION = ->(step_index, steps_size) { step_index + steps_size }
     onboarding.progress(CALCULATION)
     ```

   - Alternatively, set the custom progress calculation formula during the
     onboarding definition to automatically calculate the progress.

     ```ruby
     class User
       include Onboardable

       CALCULATION = ->(step_index, steps_size) { step_index + steps_size }

       has_onboarding progress_calculation: CALCULATION do
         # ...
       end
     end
     ```

6. **Access Current Step Details**

   Retrieve details about the current step, which can include the name,
   custom data, and status, to display appropriate information or help
   the user understand their current position in the onboarding process.

   ```ruby
   onboarding.current_step
   onboarding.current_step.name
   onboarding.current_step.data
   onboarding.current_step.status
   ```

7. **Complete the Onboarding Process**

   Once the user reaches the last step and completes it, finalize the
   onboarding process, which might involve setting a user attribute to
   indicate completion or triggering other application logic.

   ```ruby
   # Direct Check Approach
   if onboarding.last_step?
     # Implement finalization processes like updating user attributes
   end

   # Exception Handling Approach
   begin
     onboarding.next_step!
   rescue Onboardable::LastStepError
     # Implement finalization processes like updating user attributes
   end
   ```

8. **Exit the Onboarding Process Early**

   Handle cases where a user decides to discontinue the onboarding
   by attempting to navigate back from the initial step.

   ```ruby
   # Direct Check Approach
   if onboarding.first_step?
     # Implement cleanup or final actions for an orderly exit
   end

   # Exception Handling Approach
   begin
     onboarding.prev_step!
   rescue Onboardable::FirstStepError
     # Implement cleanup or final actions for an orderly exit
   end
   ```

By following these steps, developers can effectively manage and facilitate a
user-friendly onboarding process using the Onboardable gem.

## 🛠 Development

1. After checking out the repo, run `bin/setup` to install dependencies.
2. Then, run `rake spec` to run the tests.
3. Also run `bin/console` for an interactive prompt that will allow you to experiment.
4. To install this gem onto your local machine, run `bundle exec rake install`.
5. To release a new version, update the version number in `version.rb`.
6. After, run `bundle exec rake release`, which will create a git tag for the version.
7. Push git commits and the created tag.
8. Then push the `.gem` file to [rubygems.org](https://rubygems.org).

## 🤝 Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/dmrAnderson/onboardable>.
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the [code of conduct](https://github.com/dmrAnderson/onboardable/blob/main/CODE_OF_CONDUCT.md).

## 📃 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 📜 Code of Conduct

Everyone interacting with the Onboardable project's codebases, issue trackers,
chat rooms, and mailing lists are expected to follow the [code of conduct](https://github.com/dmrAnderson/onboardable/blob/main/CODE_OF_CONDUCT.md).
