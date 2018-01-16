class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  def end_activity!
    self.update!(end_time: DateTime.current)
  end

  def duration
    (self.end_time || DateTime.current.end_of_day).to_f - self.start_time.to_f
  end
end
