# SimpleFactory

A simple test data generator.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_factory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_factory

## Usage

### Define factory

```ruby
# Assume that Item model was defined like this:
Item = Struct.new(:name, :price)

class ItemFactory < SimpleFactory::Factory
  define do
    # Define default params here.
    name 'Milk'
    price 100
  end

  def create(params)
    # Code to create an object here.
    Item.new(params[:name], params[:price])
  end
end
```

### Use factory

```ruby
# Simple usage
ItemFactory.create # => #<struct Item name="Milk", price=100>

# Use with overriding params
ItemFactory.create(name: 'Cookie', price: 298) # => #<struct Item name="Cookie", price=298>
```

### Define Factory with YAML

`model.yml`:

```yaml
_sample:
  - name: Milk
    price: 100
  - name: Cookie
    price: 298
```

Define a factory with YAML definitions:

```ruby
class ItemFactory < SimpleFactory::Factory
  define '/path/to/model.yml'
  # or, if you set `SimpleFactory.definitions_dir = '/path/to'`, simply:
  #   define 'model.yml'

  def create(params)
    Item.new(params[:name], params[:price])
  end
end
```

Use the factory:

```ruby
ItemFactory.create # returns Milk or Cookie randomly.
```

Other options:

```yaml
name: # name will be "Taro" or "Hanako" randomly.
  _sample:
    - Taro
    - Hanako
email: # email will be "user1@example.com", "user2@example.com", ... in series.
  _sequence: 'user%{i}@example.com'
```

## License

MIT
