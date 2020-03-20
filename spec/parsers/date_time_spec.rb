# frozen_string_literal: true

require "spec_helper"
require "date"
require "time"

RSpec.describe ActiveRecordDelocalize::Parsers::DateTime do
  it "should parse date" do
    parser = described_class.new("%Y, %B, %d", :date)
    expect(parser.call("2020, январь, 01")).to eq(Date.new(2020, 1, 1))
  end

  it "should parse time" do
    parser = described_class.new("%Y, %B, %d в %H:%M:%S", :time)
    expect(parser.call("2020, январь, 01 в 22:10:01")).to eq(Time.new(2020, 1, 1, 22, 10, 1))
  end
end
