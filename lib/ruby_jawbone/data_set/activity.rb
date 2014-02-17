require 'ruby_jawbone/data_set/base'

module RubyJawbone
  module DataSet
    class Activity < Base
      attr_reader :date, :steps, :distance, :total_time_active, :total_time_inactive, :longest_time_active,
                  :longest_time_inactive, :calories_burned_through_activity, :total_calories_burned

      def initialize(date, steps, distance, total_time_active, total_time_inactive, longest_time_active, longest_time_inactive, calories_burned_through_activity, total_calories_burned)
        @date = date
        @steps = steps
        @distance = distance
        @total_time_active = total_time_active
        @total_time_inactive = total_time_inactive
        @longest_time_active = longest_time_active
        @longest_time_inactive = longest_time_inactive
        @calories_burned_through_activity = calories_burned_through_activity
        @total_calories_burned = total_calories_burned
      end
    end
  end
end
