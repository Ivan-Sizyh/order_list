# frozen_string_literal: true

class Company < ActiveRecord::Base
end

class Item < ActiveRecord::Base
  belongs_to :company
  ordered_list on: :company
end
