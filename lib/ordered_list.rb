# frozen_string_literal: true

require_relative 'ordered_list/version'

module OrderedList
  attr_reader :ordered_list_scope_columns

  def ordered_list(on:)
    @ordered_list_scope_columns = Array(on).map do |name|
      reflection = reflect_on_association(name)

      reflection ? reflection.foreign_key : name.to_s
    end
  end
end

ActiveSupport.on_load(:active_record) { extend OrderedList }
