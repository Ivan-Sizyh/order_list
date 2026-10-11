# frozen_string_literal: true

module OrderedList
  class PositionUpdater
    def initialize(record)
      @record = record
    end

    def insert
      clamp_position
      shift_following_positions
    end

    private

    attr_reader :record

    def clamp_position
      last_position = list.maximum(:position).to_i + 1

      record.position = (record.position || last_position).clamp(1, last_position)
    end

    def shift_following_positions
      negated_count = list.where(position: record.position..).update_all('position = -position')
      return if negated_count.zero?

      list.where(position: ..-1).update_all('position = -position + 1')
    end

    def list
      record.class.where(list_scope)
    end

    def list_scope
      record.class.ordered_list_scope_columns.index_with { |column| record[column] }
    end
  end
end
