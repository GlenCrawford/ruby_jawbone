require 'spec_helper'

describe RubyJawbone::FileReaders::Base do
  let(:file) { double "File" }

  describe "#initialize" do
    it "receives and sets the file" do
      file_reader = RubyJawbone::FileReaders::Base.new(file)

      expect(file_reader.file).to eq file
    end
  end
end
