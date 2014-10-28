require 'active_support/core_ext/date/calculations.rb'
require 'active_support/core_ext/numeric/time'

require 'yaml'

class TimeSim

  def random_int(min, max)
    rand(max - min) + min
  end

  def mydays_ago(dayrange)
    dayrange.day.ago.to_date
  end

  def testime
    time = Time.now
    puts time
    puts time.to_i
    startdate = Date.parse('2012-12-09')
    puts startdate
    startime = startdate.to_time
    puts startime
    puts startime.to_i

    daysago = 10
    daysago = daysago.day.ago.to_date
    puts daysago

    puts mydays_ago(10).to_date
    puts mydays_ago(-10).to_date
  end

  def get_random_time_between_two_dates(min_date,max_date)
    min_date_seconds = min_date.to_time.to_i
    max_date_seconds = max_date.to_time.to_i
    random_date_seconds = random_int(min_date_seconds,max_date_seconds)
    Time.at(random_date_seconds).to_time
  end

  def get_random_time(day_interval)
    max_date = mydays_ago(-day_interval).to_date
    min_date = mydays_ago(day_interval).to_date
    #puts min_date
    #puts max_date
    get_random_time_between_two_dates(min_date,max_date)
  end

#
# The day_interval @options.d by default in the math simulator is 1
# Gets a random array of times and then sorts them for yesterday and today
#
# Still need to work out getting timestamps for today only
# If there is a need to do this we can do it later
#

  def get_sorted_time_array(day_interval,n)
    timeary = []
    for i in 1..n
      mytime = get_random_time(day_interval)
      timeary.push(mytime)
    end
    timeary.sort
  end

end

=begin
ts = TimeSim.new
timeary = ts.get_sorted_time_array(1,10)
puts timeary.sort
=end
