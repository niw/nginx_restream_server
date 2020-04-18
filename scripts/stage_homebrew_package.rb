#!/usr/bin/env brew ruby
# frozen_string_literal: true

NAME = ARGV.shift

begin
  formula = Formulary.factory(NAME)
rescue FormulaUnavailableError
  warn "#{NAME} is not found."
  exit 1
end

TARGET = ARGV.shift

unless TARGET
  warn 'Staging target path it not specified.'
  exit 1
end

unless formula.pkg_version == formula.installed_version
  warn "Installed #{NAME} version: #{formula.installed_version} is not current active package version: #{formula.pkg_version}"
  exit 1
end

# Somehow `active_spec` method is protected.
active_spec = formula.send(formula.active_spec_sym)

active_spec.stage(File.expand_path(TARGET))
