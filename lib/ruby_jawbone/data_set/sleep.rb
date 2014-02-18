require 'ruby_jawbone/data_set/base'

module RubyJawbone
  module DataSet
    class Sleep < Base
      attr_reader :date, :bed_time, :asleep_time, :awake_time, :total_time_asleep, :total_time_awake,
                  :total_time_in_light_sleep, :total_time_in_deep_sleep, :times_woken_up

      def initialize(date, bed_time, asleep_time, awake_time, total_time_asleep, total_time_awake, total_time_in_light_sleep, total_time_in_deep_sleep, times_woken_up)
        @date = date
        @bed_time = bed_time
        @asleep_time = asleep_time
        @awake_time = awake_time
        @total_time_asleep = total_time_asleep
        @total_time_awake = total_time_awake
        @total_time_in_light_sleep = total_time_in_light_sleep
        @total_time_in_deep_sleep = total_time_in_deep_sleep
        @times_woken_up = times_woken_up
      end
    end
  end
end
