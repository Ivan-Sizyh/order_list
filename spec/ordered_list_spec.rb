# frozen_string_literal: true

RSpec.describe OrderedList do
  it 'makes ordered_list available in ActiveRecord models' do
    model = Class.new(ActiveRecord::Base)

    expect(model).to respond_to(:ordered_list)
  end

  describe '.ordered_list' do
    it 'remembers the foreign key of a belongs_to scope' do
      model = Class.new(ActiveRecord::Base) do
        belongs_to :company
        ordered_list on: :company
      end

      expect(model.ordered_list_scope_columns).to eq(['company_id'])
    end

    it 'remembers the name of a plain column scope' do
      model = Class.new(ActiveRecord::Base) do
        ordered_list on: :active
      end

      expect(model.ordered_list_scope_columns).to eq(['active'])
    end

    it 'remembers every column of a scope given as an array' do
      model = Class.new(ActiveRecord::Base) do
        belongs_to :company
        ordered_list on: %i(company active)
      end

      expect(model.ordered_list_scope_columns).to eq(%w(company_id active))
    end
  end
end
