# frozen_string_literal: true

module ActiveRecordDelocalize
  module Railtie
    def delocalize(attrs)
      attrs.each do |attr, options|
        parser = ActiveRecordDelocalize::Parser.new(options)
        define_method("#{attr}=") do |value|
          write_attribute(attr.to_sym, parser.call(value))
        end
      end
    end
  end
end
