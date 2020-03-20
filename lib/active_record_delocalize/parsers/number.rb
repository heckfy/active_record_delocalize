# frozen_string_literal: true

module ActiveRecordDelocalize
  module Parsers
    class Number
      attr_reader :format

      def initialize(format)
        @format = format

        @format = I18n.t!("number.#{@format}.format") if @format.is_a?(Symbol)
      end

      def call(value = "")
        delimiter, separator = format.values_at(:delimiter, :separator)
        return value if !separator || !delimiter

        value.gsub(separator, "").gsub(delimiter, ".")
      end
    end
  end
end
