# frozen_string_literal: true

require 'active_record'
require 'db-query-matchers'
require 'ordered_list'

require_relative 'support/database'
require_relative 'support/models'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.order = :random

  config.before do
    Item.delete_all
    Company.delete_all
  end
end
