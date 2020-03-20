# frozen_string_literal: true

module ActiveRecordDelocalize
  module Parsers
    class DateTime
      attr_reader :format, :type

      def initialize(format, type)
        @format = format
        @type = type

        @format = I18n.t!("#{type}.formats.#{@format}") if @format.is_a?(Symbol)
      end

      def call(value)
        return value unless format

        value = Time.strptime(translate(value), format)
        type == :date ? value.to_date : value
      end

      private

      def translates
        {
          month_names: Date::MONTHNAMES.compact,
          abbr_month_names: Date::ABBR_MONTHNAMES.compact,
          day_names: Date::DAYNAMES,
          abbr_day_names: Date::ABBR_DAYNAMES
        }
          .map do |k, v|
          Hash[(begin
                              I18n.t!("date.#{k}")
                rescue StandardError
                  []
                            end).compact.zip(v)]
        end
          .reduce({}, :merge)
      end

      def translate(value)
        translates.each do |k, v|
          value = value.gsub(k, v)
        end
        value
      end
    end
  end
end
