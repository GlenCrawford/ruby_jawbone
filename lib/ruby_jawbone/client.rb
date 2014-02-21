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

      activity = parsed_data[:activity].map do |parsed_activity|
        DataSet::Activity.new(*parsed_activity.values)
      end

      sleep = parsed_data[:sleep].map do |parsed_sleep|
        DataSet::Sleep.new(*parsed_sleep.values)
      end

      @activity += activity
      @sleep += sleep
    end
  end
end
