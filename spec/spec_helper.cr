ENV["LUCKY_ENV"] = "test"
ENV["PORT"] = "5001"
require "spec"
require "../src/app"
require "./support/**"
require "../db/migrations/**"

# Add/modify files in spec/setup to start/configure programs or run hooks
#
# By default there are scripts for setting up and cleaning the database
require "./setup/**"

include Carbon::Expectations
include Lucky::RequestExpectations

Avram::Migrator::Runner.new.ensure_migrated!
Avram::SchemaEnforcer.ensure_correct_column_mappings!
Habitat.raise_if_missing_settings!
