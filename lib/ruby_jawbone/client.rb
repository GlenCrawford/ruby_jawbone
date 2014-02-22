require 'ruby_jawbone/file_readers/jawbone'

require 'ruby_jawbone/data_set/activity'
require 'ruby_jawbone/data_set/sleep'

module RubyJawbone
  class Client
    attr_reader :activity, :sleep

    def initialize
      @activity = []
      @sleep = []
    end

    def process_file(file)
      parsed_data = FileReaders::Jawbone.new(file).parse_file

      parsed_data.each do |data_type, data_sets|
        # Need to think about some of this terminlogy around "data sets" and so on soon.
        data_set_klass = {
          :activity => DataSet::Activity,
          :sleep => DataSet::Sleep
        }[data_type]

        data_sets.each do |data_set|
          add_to_collection data_type, data_set_klass.new(*data_set.values)
        end
      end
    end

    private

    def add_to_collection(collection_name, value)
      # Raise here if invalid collection name.
      send(collection_name).push(value)
    end
  end
end
