require 'spec_helper'

describe RubyJawbone::DataSet::Sleep do
  let(:date) { Date.new(2014, 1, 21) }
  let(:bed_time) { Time.local(2014, 1, 20, 22, 59) }
  let(:asleep_time) { Time.local(2014, 1, 20, 23, 11) }
  let(:awake_time) { Time.local(2014, 1, 21, 8, 4) }
  let(:total_time_asleep) { 27478 }
  let(:total_time_awake) { 5222 }
  let(:total_time_in_light_sleep) { 17338 }
  let(:total_time_in_deep_sleep) { 10140 }
  let(:times_woken_up) { 3 }

  let(:sleep) { RubyJawbone::DataSet::Sleep.new(date, bed_time, asleep_time, awake_time, total_time_asleep, total_time_awake, total_time_in_light_sleep, total_time_in_deep_sleep, times_woken_up) }

  describe "#initialize" do
    it "receives the sleep values and sets them into the correct properties" do
      expect(sleep.date).to eq date
      expect(sleep.bed_time).to eq bed_time
      expect(sleep.asleep_time).to eq asleep_time
      expect(sleep.awake_time).to eq awake_time
      expect(sleep.total_time_asleep).to eq total_time_asleep
      expect(sleep.total_time_awake).to eq total_time_awake
      expect(sleep.total_time_in_light_sleep).to eq total_time_in_light_sleep
      expect(sleep.total_time_in_deep_sleep).to eq total_time_in_deep_sleep
      expect(sleep.times_woken_up).to eq times_woken_up
    end
  end
end
