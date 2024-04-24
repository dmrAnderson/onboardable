# 🚀 Onboardable

![Build](https://img.shields.io/github/actions/workflow/status/dmrAnderson/onboardable/ci.yml)
![Code Coverage](https://img.shields.io/coverallsCoverage/github/dmrAnderson/onboardable)

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

If bundler is not being used to manage dependencies, install the gem by executing:

```shell
gem install onboardable
```

## ⚙️ Usage

First, ensure that the Onboardable gem is installed and properly set up in your
project as per the installation guide provided earlier.

### Basic Configuration

1. **Include Onboardable in Your Class**

   Decide which Ruby class should have the onboarding process.
   For example, if you want to add an onboarding process to a User
   class, you would modify the class as follows:

   ```ruby
   class User
     include Onboardable
   end
   ```

1. **Define Onboarding Steps**

   You can define the steps involved in the onboarding process using
   the has_onboarding method provided by the gem. Here's an example of
   how to define a simple onboarding process with custom steps:

   ```ruby
   class User
     has_onboarding do
       step 'Create Account', UserCreate
       step 'Verify Email', EmailVerify
       step 'Complete Profile', AddressCreate
       step 'Introduction Tour'
     end
   end
   ```

### Using the Onboarding Steps

Once you have defined the onboarding steps, you can use them within your
application to track user progress, determine the next steps, and manage
transitions between steps.

1. **Accessing Onboarding Steps**

   You can retrieve the onboarding steps for any instance of your class:

   ```ruby
   user = User.new
   user.onboarding.steps  # => Returns the list of steps defined
   ```

1. **Navigating Steps**

   Implement navigation between steps using the methods provided:

   ```ruby
   user.onboarding.next_step!  # Advances to the next step
   user.onboarding.prev_step!  # Moves back to the previous step
   ```

   You can check if a step is the first or the last to handle edge
   cases in your UI or logic:

   ```ruby
   user.onboarding.first_step?  # => true if the current step is the first
   user.onboarding.last_step?   # => true if the current step is the last
   ```

## 🛠 Development

1. After checking out the repo, run `bin/setup` to install dependencies.
1. Then, run `rake spec` to run the tests.
1. Also run `bin/console` for an interactive prompt that will allow you to experiment.
1. To install this gem onto your local machine, run `bundle exec rake install`.
1. To release a new version, update the version number in `version.rb`.
1. After run `bundle exec rake release`, which will create a git tag for the version.
1. Push git commits and the created tag.
1. Then push the `.gem` file to [rubygems.org](https://rubygems.org).

## 🤝 Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/dmrAnderson/onboardable>.
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the [code of conduct](https://github.com/dmrAnderson/onboardable/blob/main/CODE_OF_CONDUCT.md).

## 📃 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 📜 Code of Conduct

Everyone interacting in the Onboardable project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dmrAnderson/onboardable/blob/main/CODE_OF_CONDUCT.md).
