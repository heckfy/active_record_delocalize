# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActiveRecordDelocalize::Parser do
  describe ":date" do
    it "should init with :default date format" do
      parser = described_class.new(:date)
      expect(parser.call("15.12.1987")).to eq(Date.new(1987, 12, 15))
    end

    it "should init with date format from locale file" do
      parser = described_class.new({ date: :short })
      expect(parser.call("15.12.87")).to eq(Date.new(1987, 12, 15))
    end

    it "should init with date format from string" do
      parser = described_class.new({ date: "%d/%m/%Y" })
      expect(parser.call("15/12/1987")).to eq(Date.new(1987, 12, 15))
    end
  end

  describe ":time" do
    it "should init with :default time format" do
      parser = described_class.new(:time)
      expect(parser.call("15.12.1987 в 22:15:19")).to eq(Time.new(1987, 12, 15, 22, 15, 19))
    end

    it "should init with time format from locale file" do
      parser = described_class.new({ time: :short })
      expect(parser.call("15.12.87 в 22:15:19")).to eq(Time.new(1987, 12, 15, 22, 15, 19))
    end

    it "should init with time format from string" do
      parser = described_class.new({ time: "%d/%m/%Y в %H:%M:%S" })
      expect(parser.call("15/12/1987 в 22:15:19")).to eq(Time.new(1987, 12, 15, 22, 15, 19))
    end
  end

  describe ":number" do
    it "should init with :default number format" do
      parser = described_class.new(:number)
      expect(parser.call("1 555.99")).to eq("1555.99")
    end

    it "should init with number format from locale file" do
      parser = described_class.new({ number: :currency })
      expect(parser.call("1,555.99")).to eq("1555.99")
    end

    it "should init with number format from object" do
      parser = described_class.new({ number: { separator: " ", delimiter: "," } })
      expect(parser.call("1 555,99")).to eq("1555.99")
    end
  end
end
