require 'spec_helper'

describe RubyJawbone::FileReaders::Jawbone do
  let(:file) { double "File" }
  let(:file_reader) { RubyJawbone::FileReaders::Jawbone.new(file) }

  let(:file_rows) do
    {
      :sleep_tracked_and_fell_asleep_after_midnight => "20140119,42.586301369863016,1676.467993150685,,0,1.75,9644.0,609.769522205,13579.0,24960.0,2838.0,12540.0,17157.0,2286.237515355685,0.0,0.0,14039.0,2237.0,36727.0,1.0,12427.0,1.0,9022.0,22063.0,13041.0,59.0,0.0,65.0".split(","),
      :sleep_tracked_and_fell_asleep_before_midnight => "20140121,42.59178082191781,1676.430979452055,,0,1.75,6126.0,402.170217812061,8984.0,30180.0,2779.0,10140.0,11171.0,2078.601197264116,0.0,0.0,-2881.0,5222.0,29052.0,3.0,-3648.0,1.0,10140.0,27478.0,17338.0,72.0,0.0,65.0".split(","),
      :sleep_not_tracked => "20140205,42.632876712328766,1676.1533767123287,,0,1.75,5946.0,396.927790523,8792.0,31800.0,2419.0,7440.0,10921.0,2073.081167235329,0.0,0.0,,,,,,,,,,,,65.0".split(",")
    }
  end

  describe "#parse_file" do
    #
  end

  describe "#parse_row" do
    describe "activity" do
      context "sleep tracked and fell asleep after midnight" do
        it "parses and returns the activity data from the row" do
          activity, _ = file_reader.parse_row(file_rows[:sleep_tracked_and_fell_asleep_after_midnight])

          expect(activity).to eq({
            :date => Date.new(1999, 12, 31),
            :steps => "?",
            :distance => "?",
            :total_time_active => "?",
            :total_time_inactive => "?",
            :longest_time_active => "?",
            :longest_time_inactive => "?",
            :calories_burned_through_activity => "?",
            :total_calories_burned => "?"
          })
        end
      end

      context "sleep tracked and fell asleep before midnight" do
        it "parses and returns the activity data from the row" do
          activity, _ = file_reader.parse_row(file_rows[:sleep_tracked_and_fell_asleep_before_midnight])

          expect(activity).to eq({
            :date => Date.new(1999, 12, 31),
            :steps => "?",
            :distance => "?",
            :total_time_active => "?",
            :total_time_inactive => "?",
            :longest_time_active => "?",
            :longest_time_inactive => "?",
            :calories_burned_through_activity => "?",
            :total_calories_burned => "?"
          })
        end
      end

      context "sleep not tracked" do
        it "parses and returns the activity data from the row" do
          activity, _ = file_reader.parse_row(file_rows[:sleep_not_tracked])

          expect(activity).to eq({
            :date => Date.new(1999, 12, 31),
            :steps => "?",
            :distance => "?",
            :total_time_active => "?",
            :total_time_inactive => "?",
            :longest_time_active => "?",
            :longest_time_inactive => "?",
            :calories_burned_through_activity => "?",
            :total_calories_burned => "?"
          })
        end
      end
    end

    describe "sleep" do
      context "sleep tracked and fell asleep after midnight" do
        it "parses and returns the sleep data from the row" do
          _, sleep = file_reader.parse_row(file_rows[:sleep_tracked_and_fell_asleep_after_midnight])

          expect(sleep).to eq({
            :date => Date.new(1999, 12, 31),
            :bed_time => Time.local(1999, 12, 31, 23, 59),
            :asleep_time => Time.local(1999, 12, 31, 23, 59),
            :awake_time => Time.local(1999, 12, 31, 23, 59),
            :total_time_asleep => "?",
            :total_time_awake => "?",
            :total_time_in_light_sleep => "?",
            :total_time_in_deep_sleep => "?",
            :times_woken_up => "?"
          })
        end
      end

      context "sleep tracked and fell asleep before midnight" do
        it "parses and returns the sleep data from the row" do
          _, sleep = file_reader.parse_row(file_rows[:sleep_tracked_and_fell_asleep_before_midnight])

          expect(sleep).to eq({
            :date => Date.new(1999, 12, 31),
            :bed_time => Time.local(1999, 12, 31, 23, 59),
            :asleep_time => Time.local(1999, 12, 31, 23, 59),
            :awake_time => Time.local(1999, 12, 31, 23, 59),
            :total_time_asleep => "?",
            :total_time_awake => "?",
            :total_time_in_light_sleep => "?",
            :total_time_in_deep_sleep => "?",
            :times_woken_up => "?"
          })
        end
      end

      context "sleep not tracked" do
        it "parses and returns the sleep data from the row" do
          _, sleep = file_reader.parse_row(file_rows[:sleep_not_tracked])

          expect(sleep).to eq({
            :date => Date.new(1999, 12, 31),
            :bed_time => Time.local(1999, 12, 31, 23, 59),
            :asleep_time => Time.local(1999, 12, 31, 23, 59),
            :awake_time => Time.local(1999, 12, 31, 23, 59),
            :total_time_asleep => "?",
            :total_time_awake => "?",
            :total_time_in_light_sleep => "?",
            :total_time_in_deep_sleep => "?",
            :times_woken_up => "?"
          })
        end
      end
    end
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
