# ordered_list

Keeps an integer `position` column sequential (1..n) inside a scope of ActiveRecord records. PostgreSQL only.

## Usage

```ruby
class Auth < ApplicationRecord
  belongs_to :company
  ordered_list on: :company
end
```

## Development

```bash
bundle install
bundle exec rspec
```
