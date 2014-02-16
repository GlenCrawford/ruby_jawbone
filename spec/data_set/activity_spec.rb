require 'spec_helper'

describe RubyJawbone::DataSet::Activity do
  let(:date) { Date.new(2014, 1, 21) }
  let(:steps) { 11171 }
  let(:distance) { 8984 }
  let(:total_time_active) { 6126 }
  let(:total_time_inactive) { 30180 }
  let(:longest_time_active) { 2779 }
  let(:longest_time_inactive) { 10140 }
  let(:calories_burned_through_activity) { 402 }
  let(:total_calories_burned) { 2078 }

  let(:activity) { RubyJawbone::DataSet::Activity.new(date, steps, distance, total_time_active, total_time_inactive, longest_time_active, longest_time_inactive, calories_burned_through_activity, total_calories_burned) }

  describe "#initialize" do
    it "receives the activity values and sets them into the correct properties" do
      expect(activity.date).to eq date
      expect(activity.steps).to eq steps
      expect(activity.distance).to eq distance
      expect(activity.total_time_active).to eq total_time_active
      expect(activity.total_time_inactive).to eq total_time_inactive
      expect(activity.longest_time_active).to eq longest_time_active
      expect(activity.longest_time_inactive).to eq longest_time_inactive
      expect(activity.calories_burned_through_activity).to eq calories_burned_through_activity
      expect(activity.total_calories_burned).to eq total_calories_burned
    end
  end
end
