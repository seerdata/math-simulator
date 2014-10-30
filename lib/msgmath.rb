require_relative './msgbase'
require_relative './timesim'
require_relative './timeseriesim'

class MsgMath < Msgbase

  def initialize(options)
    @timesim = TimeSim.new
    @timeseriesim = TimeSeriesim.new
    @options = options
  end

  def get_key
    ['ios','android','java','python','ruby'].sample
  end

  def get_interval
    ['days','weeks']
  end

  def get_calculation
    ['count','sum','average','standard_deviation','linear_regression']
  end

#
# @options.d by default in the math simulator is 1
# Gets a random array of times and then
# sorts them for yesterday and today
#
# Still need to work out getting timestamps for today only
# If there is a need to do this we can do it later
#

  def get_time_array(n)
    @timesim.get_sorted_time_array(@options.d,n)
  end

  def get_time_series_array_with_noise(n)
    # Eventually these parameters could be in Options
    start_slope = 1.0
    noise = 7.1
    @timeseriesim.get_one_noisy_value(n,start_slope,noise)
  end

  def buildmsg(time,value)
    msg_hash = Hash.new
    msg_hash[:access_token] = get_token_id
    dimension = get_dimension
    msg_hash[:dimension] = dimension
    msg_hash[:key] = get_key
    msg_hash[:value] = value.to_s
    msg_hash[:created_at] = time
    msg_hash[:interval] = get_interval
    msg_hash[:calculation] = get_calculation
    msg_hash
  end

  def build_n_messages(n)
    x = n + 1
    messages = []
    arytime = get_time_array(x)
    arytimeseries = get_time_series_array_with_noise(x)

    print 'arytime size = ', arytime.length; puts
    print 'arytime series size = ', arytimeseries.length; puts; puts

    for i in 0..n
      print i, '. '
      print arytime[i], ' -> '
      print arytimeseries[i]; puts
      mymsg = buildmsg(arytime[i],arytimeseries[i])
      messages.push(mymsg)
    end
    messages
  end
end

=begin
require_relative './options'
myoptions = Options.new
options = myoptions.parse(ARGV)
msg = MsgMath.new(options)
n = 4
msgs = msg.build_n_messages(n)
puts
for i in 0..n
  puts msgs[i]; puts
end
=end
