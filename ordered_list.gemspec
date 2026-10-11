# frozen_string_literal: true

require_relative 'lib/ordered_list/version'

Gem::Specification.new do |spec|
  spec.name = 'ordered_list'
  spec.version = OrderedList::VERSION
  spec.authors = ['Ivan Sizyh']
  spec.summary = 'Sequential integer positions for ActiveRecord lists (PostgreSQL only)'

  spec.required_ruby_version = '>= 3.4'

  spec.files = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 7.2'
  spec.add_dependency 'activesupport', '>= 7.2'
end
