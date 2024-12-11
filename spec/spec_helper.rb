# frozen_string_literal: true
  if ENV["FAST_CI_SECRET_KEY"]
    require "fast_ci"
    require "rspec/core/runner"
    require "fast_ci/runner_prepend"

    class RSpec::Core::ExampleGroup
      def self.filtered_examples
        ids = Thread.current[:fastci_scoped_ids] || ""

        RSpec.world.filtered_examples[self].filter do |ex|
          ids == "" || /^#{ids}($|:)/.match?(ex.metadata[:scoped_id])
        end
      end
    end

    RSpec::Core::Runner.prepend(FastCI::RunnerPrepend)
  end

require 'webmock/rspec'

RSpec.configure do |config|
  # The following three options will be default in RSpec 4.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Allows context or example to be tagged with :focus to only run those specs.
  config.filter_run_when_matching :focus

  # Use the documentation formatter by default when running just one spec.
  config.default_formatter = 'doc' if config.files_to_run.one?

  # Show 10 slowest examples.
  config.profile_examples = 10

  # Run in random order to reduce chance for interdependencies.
  config.order = :random

  # Allows the suite to be re-run with a particular seed using --seed
  Kernel.srand config.seed

  # Require specs to begin with RSpec.describe so the global namespace is not
  # contaminated with RSpec methods.
  config.expose_dsl_globally = false

  # Limits the available syntax (e.g. forces expect(…).to)
  config.disable_monkey_patching!

  # Useful in combination with fail-fast when refactoring specs.
  config.register_ordering(:alphabet, &:sort)
end
