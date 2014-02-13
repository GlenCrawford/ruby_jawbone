require 'ruby_jawbone/file_readers/base'
require 'csv'

module RubyJawbone
  module FileReaders
    class Jawbone < Base
      attr_reader :file

      def initialize(file)
        @file = file
      end

      def parse_file
        {:activity => [], :sleep => []}.tap do |results|
          CSV.foreach(file, :headers => :first_row) do |row|
            activity, sleep = parse_row(row)

            results[:activity] << activity
            results[:sleep] << sleep
          end
        end
      end

      def parse_row(row)
        date = Date.strptime(row[0], "%Y%m%d")

        activity = {
          :date => date,

          :steps => row[12].to_i,                           # Total steps taken.
          :distance => row[8].to_i,                         # Total distance travelled (in meters).

          :total_time_active => row[6].to_i,                # Total active time (in seconds).
          :total_time_inactive => row[9].to_i,              # Total inactive time (in seconds).

          :longest_time_active => row[10].to_i,             # Longest time active (in seconds).
          :longest_time_inactive => row[11].to_i,           # Longest time idle (in seconds).

          :calories_burned_through_activity => row[7].to_i, # Number of calories burned directly from activity.
          :total_calories_burned => row[13].to_i            # Total number of calories burned (including BMR [Basal Metabolic Rate]).
        }

        sleep = {
          :date => date,

          :bed_time => parse_time(row[20].to_i, date),      # Time entered sleep mode.
          :asleep_time => parse_time(row[16].to_i, date),   # Time fell asleep.
          :awake_time => parse_time(row[18].to_i, date),    # Final time woken up.

          :total_time_asleep => row[23].to_i,               # Total time asleep during sleep period (in seconds).
          :total_time_awake => row[17].to_i,                # Time awake during sleep period (in seconds).

          :total_time_in_light_sleep => row[24].to_i,       # Time in light sleep during sleep period (in seconds).
          :total_time_in_deep_sleep => row[22].to_i,        # Time in deep sleep during sleep period (in seconds).

          :times_woken_up => row[19].to_i                   # Times woken up during sleep period.
        }

        return activity, sleep
      end

      protected

      # The Jawbone data stores times in an offset before or after midnight (in seconds):
      # * If negative: before midnight.
      # * If positive: after midnight.
      #
      # Examples:
      # * Timestamp -3648 for period 21/01/2014 = 10:59pm on 20/01/2014 (before midnight the day before).
      # * Timestamp 29052 for period 21/01/2014 = 8:04am on 21/01/2014.
      def parse_time(timestamp, date)
        minutes = timestamp / 60.to_f

        hour = (minutes / 60).to_i.abs
        minutes = (minutes % 60).to_i

        # If the time is before midnight, subtract a day and set the hour to the number
        # of hours before midnight.
        if timestamp < 0
          date = date - 1
          hour = 23 - hour
        end

        Time.local(date.year, date.month, date.day, hour, minutes)
      end
    end
  end
end
