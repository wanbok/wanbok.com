class AddUsageDurationPerDayToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :usage_duration_per_day, :integer
  end
end
