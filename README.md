# ActiveRecordDelocalize

active_record_delocalize provides localized date, time and number parsing functionality for active_record attributes.

## What does it do?

Sometimes you want to save localized data (like date or number) to database:

```ruby
order = Order.new
order.cost = "$ 6 999,99"
order.save
```

But first you need to parse them to active-record acceptable format. You may manual override attribute accessors:

```ruby
class Order < ActiveRecord::Base
  def cost=(cost)
    write_attribute(:cost, cost.gsub(/\$|\s/, "").gsub(',', '.'))
  end
end
```

But active_record_delocalize make it easier:

```ruby
class Order < ActiveRecord::Base
  delocalize cost: :number
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record_delocalize'
```

And then execute:

    $ bundle

## Usage

You need specify delocalize value per each model using the following declarative DSL:

```ruby
class Order < ActiveRecord::Base
  delocalize cost: :number, delivered_on: :date
end
```

Where **cost** and **delivered_on** is attribute names and **number** and **date** is data types. Now **active_record_delocalize** support three types: **date**, **time** and **number**. You can also pass a data hash instead of type, where the key is the data type and the value is the format, or format name from your localize file, e.g.:


```ruby
class Order < ActiveRecord::Base
  delocalize cost: { delimiter: ",", separator: " " }, delivered_on: :short
end
```

## Configuration



In addition to your model setup, you also need to configure your locale file(s). Assuming you want to use all of delocalize's parsers (date, time, number), the required keys are:

* number.default.format.delimiter
* number.default.format.separator
* date.formats.default
* time.formats.default

For example:

```yaml
ru:
  number:
    default:
      format:
        delimiter: "."
        separator: " "
  time:
    formats:
      default: '%d.%m.%Y в %H:%M'
  date:
    formats:
      default: '%d.%m.%Y'
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/heckfy/active_record_delocalize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
