# frozen_string_literal: true

RSpec.describe OrderedList do
  it 'makes ordered_list available in ActiveRecord models' do
    expect(ActiveRecord::Base).to respond_to(:ordered_list)
  end

  describe '.ordered_list' do
    context 'when scoped by a belongs_to association' do
      let(:model) do
        Class.new(ActiveRecord::Base) do
          belongs_to :company
          ordered_list on: :company
        end
      end

      it 'remembers its foreign key' do
        expect(model.ordered_list_scope_columns).to eq(['company_id'])
      end
    end

    context 'when scoped by a plain column' do
      let(:model) do
        Class.new(ActiveRecord::Base) do
          ordered_list on: :active
        end
      end

      it 'remembers the column name' do
        expect(model.ordered_list_scope_columns).to eq(['active'])
      end
    end

    context 'when scoped by several columns' do
      let(:model) do
        Class.new(ActiveRecord::Base) do
          belongs_to :company
          ordered_list on: %i(company active)
        end
      end

      it 'remembers every column' do
        expect(model.ordered_list_scope_columns).to eq(%w(company_id active))
      end
    end
  end
end
