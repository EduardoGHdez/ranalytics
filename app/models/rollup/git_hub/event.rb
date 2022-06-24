class Rollup::GitHub::Event
  def self.call(hour)
    events = GitHub::Event::HourlyQueue.where(date: hour)

    events.group(:type).count.each do |type, count|
      GitHub::Event::HourlyRollup.create!(
        type: type,
        date: hour,
        count: count
      )
    end

    events.destroy_all
  end
end
