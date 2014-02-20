require 'spec_helper'

describe RubyJawbone::Client do
  let(:client) { RubyJawbone::Client.new }
  let(:jawbone_file_reader) { double "Jawbone File Reader" }
  let(:file) { double "File" }

  describe "#initialize" do
    it "starts off with empty collections for both activity and sleep" do
      new_client = RubyJawbone::Client.new

      expect(new_client.activity).to eq []
      expect(new_client.sleep).to eq []
    end
  end

  describe "#process_file" do
    before do
      expect(RubyJawbone::FileReaders::Jawbone).to receive(:new).and_return(jawbone_file_reader)
    end

    let(:mock_activity_1) { double "DataSet::Activity #1" }
    let(:mock_activity_2) { double "DataSet::Activity #2" }
    let(:mock_activity_3) { double "DataSet::Activity #3" }

    let(:mock_sleep_1) { double "DataSet::Activity #1" }
    let(:mock_sleep_2) { double "DataSet::Activity #2" }

    it "gets the data parsed from the file, instantiates actvity and sleep objects from that data, and builds up collections of those activity and sleep objects" do
      dates = [(Date.today - 2), (Date.today - 1), Date.today]

      expect(jawbone_file_reader).to receive(:parse_file).and_return({
        :activity => [
          {:date => dates[0], :steps => 000, :distance => 111},
          {:date => dates[1], :steps => 222, :distance => 333},
          {:date => dates[2], :steps => 444, :distance => 555},
        ],
        :sleep => [
          {:date => dates[0], :total_time_asleep => 666, :total_time_awake => 777},
          {:date => dates[1], :total_time_asleep => 888, :total_time_awake => 999}
        ]
      })

      expect(RubyJawbone::DataSet::Activity).to receive(:new).with(dates[0], 000, 111).and_return(mock_activity_1)
      expect(RubyJawbone::DataSet::Activity).to receive(:new).with(dates[1], 222, 333).and_return(mock_activity_2)
      expect(RubyJawbone::DataSet::Activity).to receive(:new).with(dates[2], 444, 555).and_return(mock_activity_3)

      expect(RubyJawbone::DataSet::Sleep).to receive(:new).with(dates[0], 666, 777).and_return(mock_sleep_1)
      expect(RubyJawbone::DataSet::Sleep).to receive(:new).with(dates[1], 888, 999).and_return(mock_sleep_2)

      client.process_file(file)

      expect(client.activity).to eq [mock_activity_1, mock_activity_2, mock_activity_3]
      expect(client.sleep).to eq [mock_sleep_1, mock_sleep_2]
    end
  end
end
