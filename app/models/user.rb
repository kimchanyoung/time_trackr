class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_activities
  scope :last_seven_days, -> { where('created_at > ?', 7.days.ago) }

  def end_activity!
    active_activity&.end_activity!
  end

  def start_activity!(activity_id)
    self.end_activity!
    self.user_activities.create!(activity_id: activity_id, start_time: DateTime.current)
  end

  def active_activity
    self.user_activities.where(end_time: nil).order(created_at: :desc).first
  end
end
