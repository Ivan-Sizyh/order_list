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

  describe 'creating records' do
    let(:company) { Company.create! }
    let(:other_company) { Company.create! }
    let!(:items) { Array.new(3) { Item.create!(company:) } }
    let(:other_items) { Array.new(2) { Item.create!(company: other_company) } }
    let(:list) { Item.where(company:).order(:position) }

    it 'puts new records to the end of the list' do
      expect(items.map(&:position)).to eq([1, 2, 3])
    end

    it 'numbers the lists of different companies independently' do
      expect(other_items.map(&:position)).to eq([1, 2])
    end

    it 'runs a single UPDATE when no record follows the new one' do
      expect { Item.create!(company:) }.to make_database_queries(matching: /\AUPDATE/, count: 1)
    end

    context 'with an explicit position' do
      let!(:inserted) { Item.create!(company:, position: 2) }

      it 'puts the record there and shifts the following ones' do
        expect(list).to eq([items[0], inserted, items[1], items[2]])
        expect(list.pluck(:position)).to eq([1, 2, 3, 4])
      end
    end

    context 'with a position beyond the end of the list' do
      let!(:inserted) { Item.create!(company:, position: 100) }

      it 'puts the record to the end' do
        expect(list).to eq([*items, inserted])
        expect(list.pluck(:position)).to eq([1, 2, 3, 4])
      end
    end

    context 'with a position below 1' do
      let!(:inserted) { Item.create!(company:, position: 0) }

      it 'puts the record to the beginning' do
        expect(list).to eq([inserted, *items])
        expect(list.pluck(:position)).to eq([1, 2, 3, 4])
      end
    end
  end
end
