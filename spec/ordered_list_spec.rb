# frozen_string_literal: true

RSpec.describe OrderedList do
  it 'makes ordered_list available in ActiveRecord models' do
    model = Class.new(ActiveRecord::Base)

    expect(model).to respond_to(:ordered_list)
  end
end
