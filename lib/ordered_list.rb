# frozen_string_literal: true

require_relative 'ordered_list/version'

module OrderedList
  def ordered_list(on:)
  end
end

ActiveSupport.on_load(:active_record) { extend OrderedList }
