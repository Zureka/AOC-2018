RAW_DATA = """[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up""".split("\n")

class TimeStamp
  attr_reader :year, :month, :day, :hour, :minute, :comment

  def initialize(year, month, day, hour, minute, comment)
    @year = year
    @month = month
    @day = day
    @hour = hour
    @minute = minute
    @comment = comment
  end
end

class Nap
  attr_reader :guard_id, :start_sleep, :wake

  def initialize(guard_id, start_sleep, wake)
    @guard_id = guard_id
    @start_sleep = start_sleep
    @wake = wake
  end
end

def make_timestamps(lines)
  lines.map { |line| make_timestamp(line) }
end

def make_timestamp(line)
  rgx = /\[([0-9]{4})-([0-9]{2})-([0-9]{2}) ([0-9]{2}):([0-9]{2})\] (.*)/
  TimeStamp.new(*line.scan(rgx).first)
end

def make_naps(timestamps)
  guard_id_rgx = /Guard #([0-9]+) begins shift/
  naps = []

  guard_id = nil
  start_sleep = nil
  wake = nil

  timestamps.each do |timestamp|
    if timestamp.comment.include? "Guard"
      guard_id = timestamp.comment.scan(guard_id_rgx).first.first.to_i
    elsif timestamp.comment.include? "falls asleep"
      start_sleep = timestamp.minute.to_i
    elsif timestamp.comment.include? "wakes up"
      wake = timestamp.minute.to_i
      naps << Nap.new(guard_id, start_sleep, wake)
      wake = start_sleep = nil
    end
  end

  naps
end

def longest_time_asleep(naps)
  time_asleep = {}
  naps.each do |nap|
    if time_asleep[nap.guard_id]
      time_asleep[nap.guard_id] += nap.wake - nap.start_sleep
    else
      time_asleep[nap.guard_id] = nap.wake - nap.start_sleep
    end
  end
  time_asleep.sort_by { |_, v| -v }.to_h.first.first
end

def most_asleep_minute_for_guard(naps, guard_id)
  minute_asleep = {}
  guards_naps = naps.select { |nap| nap.guard_id == guard_id }
  guards_naps.each do |nap|
    (nap.start_sleep...nap.wake).each do |minute|
      minute_asleep[minute] = 0 if minute_asleep[minute].nil?
      minute_asleep[minute] += 1
    end
  end
  minute_asleep.sort_by { |_, v| -v }.to_h.first.first
end

def most_asleep_minute(naps)
  minute_asleep = {}
  naps.each do |nap|
    (nap.start_sleep...nap.wake).each do |minute|
      key = "#{nap.guard_id}-#{minute}"
      minute_asleep[key] = 0 if minute_asleep[key].nil?
      minute_asleep[key] += 1
    end
  end
  minute_asleep.sort_by { |_, v| -v }.to_h.first.first
end

entries = make_timestamps(RAW_DATA)
naps = make_naps(entries)

raise "Wrong answer for guard" unless longest_time_asleep(naps) == 10
raise "Wrong answer for minute for guard" unless most_asleep_minute_for_guard(naps, 10) == 24
raise "Wrong answer for minute" unless most_asleep_minute(naps) == "99-45"

entries = []
File.open("data.txt").each do |line|
  entries << make_timestamp(line)
end

naps = make_naps(entries)
guard = longest_time_asleep(naps)
minute = most_asleep_minute_for_guard(naps, guard)
puts """--- Part 1 ---
Guard ##{guard} was most asleep on minute #{minute}.
Answer: #{guard * minute}

"""

most_asleep_minute_answer = most_asleep_minute(naps).split("-")
guard = most_asleep_minute_answer.first.to_i
minute = most_asleep_minute_answer.last.to_i
puts """--- Part 2 ---
Guard ##{guard} spent more time asleep than any other guard on minute #{minute}.
Answer: #{guard * minute}

"""
