#!/usr/bin/env ruby
# frozen_string_literal: true

require 'erb'
require 'optparse'
require 'yaml'

class Template
  class Context < BasicObject
    def initialize(context = {})
      @context = context
    end

    def method_missing(msg, *args, &block) # rubocop:disable Style/MissingRespondToMissing
      @context[msg.to_s] if !block && args.empty? && @context.key?(msg.to_s)
    end

    def self.binding(context)
      Context.new(context).instance_eval { ::Kernel.binding }
    end
  end

  attr_reader :source, :filename

  def initialize(source, filename: nil)
    @source = source
    @filename = filename
  end

  def render(context = {})
    erb = ERB.new(source, nil, '-')
    erb.filename = filename
    erb.result(Context.binding(context))
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} [options]"
  opts.on('-c', '--context FILE', 'Template context in YAML file') do |value|
    options[:context] = YAML.safe_load(File.read(File.expand_path(value)))
  end
end.parse!

STDOUT.write Template.new(STDIN.read).render(options[:context] || {})
