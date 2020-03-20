# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActiveRecordDelocalize::Parsers::Number do
  before(:all) do
    @parser = described_class.new({ delimiter: ",", separator: "." })
  end

  it "should parse a number from a string" do
    expect(@parser.call("1.299,99")).to eq("1299.99")
  end

  it "should parse a negative number from a string" do
    expect(@parser.call("-1.299,99")).to eq("-1299.99")
  end
end
