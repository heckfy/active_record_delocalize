# frozen_string_literal: true

module ActiveRecordDelocalize
  class Parser
    attr_reader :options, :parser

    def initialize(options)
      options = { options => default_options_for(options) } if options.is_a?(Symbol)

      format, @options = *options.deep_symbolize_keys.flatten

      raise_unknown_format unless %i[number date time].include?(format)

      @parser = parser_for(format)
    end

    def call(value)
      parser.call(value)
    end

    private

    def default_options_for(format)
      case format
        when :number
          I18n.t("number.default.format", default: {})
        when :date, :time
          I18n.t("#{format}.formats.default", default: nil)
        else
          raise_unknown_format
      end
    end

    def parser_for(format)
      case format
        when :number
          ActiveRecordDelocalize::Parsers::Number.new(options)
        when :date, :time
          ActiveRecordDelocalize::Parsers::DateTime.new(options, format)
        else
          raise_unknown_format
      end
    end

    def raise_unknown_format
      raise ActiveRecordDelocalize::Error("Unknown format")
    end
  end
end
