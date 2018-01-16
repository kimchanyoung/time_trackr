class UserActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def start_activity
    current_user.start_activity!(params[:activity_id])

    redirect_to root_path
  end

  def end_activity
    current_user.end_activity!
    
    redirect_to root_path
  end

  def generate_report
    collection = {}
    (0..7).each do |days_ago|
      day = (7-days_ago).days.ago.in_time_zone("Eastern Time (US & Canada)")
      puts "Checking day #{day}"
      collection[day.strftime("%m.%d.%Y")] = {}
      time_to_check = day.beginning_of_day
      while (time_to_check < day.end_of_day)
        puts "Checking time #{time_to_check}"
        next_time = time_to_check + 15.minutes
        user_activity = current_user.user_activities
          .where('start_time >= ? AND start_time <= ?', time_to_check, next_time)
          .max { |a, b| a.duration <=> b.duration } || current_user.user_activities.where('start_time <= ?', time_to_check).order(start_time: :asc).last
        collection[day.strftime("%m.%d.%Y")][time_to_check.strftime("%H:%M")] = user_activity&.activity&.description 
        time_to_check = next_time
      end
    end

    puts "Creating file"
    workbook = RubyXL::Workbook.new

    collection.each do |day, times|
      worksheet = workbook.add_worksheet(day)
      worksheet.add_cell(0, 0, "Day")
      worksheet.add_cell(1, 0, day)
      worksheet.add_cell(3, 0, "Time-slot")
      worksheet.add_cell(3, 1, "Type")

      counter = 4
      times.each do |t, d|
        worksheet.add_cell(counter, 0, t)
        worksheet.add_cell(counter, 1, d)
        counter+=1
      end
    end

    workbook.write('/Users/chan/Desktop/sample.xlsx')
  end
end
