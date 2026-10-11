# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  ENV.fetch('DATABASE_URL', 'postgres://postgres:postgres@localhost/ordered_list_test')
)

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table(:companies, force: true)

  create_table(:items, force: true) do |t|
    t.references :company, null: false
    t.integer :position, null: false
    t.index %i(company_id position), unique: true
  end
end
