# frozen_string_literal: true

require "bundler/setup"
require "active_record_delocalize"
require "rails"

ru = {
  date: {
    month_names: [nil] + %w[январь февраль март апрель май июнь июль август сентябрь октябрь ноябрь декабрь],
    formats: {
      default: "%d.%m.%Y",
      short: "%d.%m.%y"
    }
  },
  time: {
    formats: {
      default: "%d.%m.%Y в %H:%M:%S",
      short: "%d.%m.%y в %H:%M:%S"
    }
  },
  number: {
    default: {
      format: {
        separator: " ",
        delimiter: "."
      }
    },
    currency: {
      format: {
        separator: ",",
        delimiter: "."
      }
    }
  }
}

I18n.backend.store_translations :ru, ru
I18n.default_locale = :ru
I18n.locale = :ru

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
