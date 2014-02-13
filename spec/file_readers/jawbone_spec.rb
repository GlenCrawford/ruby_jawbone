require 'spec_helper'

describe RubyJawbone::FileReaders::Jawbone do
  let(:file) { double "File" }
  let(:file_reader) { RubyJawbone::FileReaders::Jawbone.new(file) }

  describe "#parse_file" do
    #
  end

  describe "#parse_row" do
    #
  end

  describe "#parse_time" do
    it "returns the correct time for a negative timestamp (before midnight)" do
      timestamp = -3648
      date = Date.new(2014, 1, 21)

      parsed_time = file_reader.send(:parse_time, timestamp, date)

      expect(parsed_time).to eq Time.local(2014, 1, 20, 22, 59)
    end

    it "returns the correct time for a positive timestamp (after midnight)" do
      timestamp = 5279
      date = Date.new(2014, 2, 7)

      parsed_time = file_reader.send(:parse_time, timestamp, date)

      expect(parsed_time).to eq Time.local(2014, 2, 7, 1, 27)
    end

    it "returns the correct time for zero timestamp (midnight)" do
      timestamp = 0
      date = Date.new(2014, 2, 7)

      parsed_time = file_reader.send(:parse_time, timestamp, date)

      expect(parsed_time).to eq Time.local(2014, 2, 7, 0, 0)
    end
  end
end
