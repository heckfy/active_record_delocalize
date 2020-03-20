# frozen_string_literal: true

# require "active_support"
# require "active_record"
require "active_record_delocalize/error"
require "active_record_delocalize/parsers/date_time"
require "active_record_delocalize/parsers/number"
require "active_record_delocalize/parser"
require "active_record_delocalize/railtie"

if defined?(Rails)
  class Railtie < Rails::Railtie
    initializer "active_record_delocalize.active_record" do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.extend ActiveRecordDelocalize::Railtie
      end
    end
  end
end
