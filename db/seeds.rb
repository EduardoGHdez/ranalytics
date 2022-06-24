require 'yajl'

hours = 6
progress = ProgressBar.create(
  title: "2022-01-01 at 00:00 GitHub Events Import",
  total: hours
)

hours.times do |hour|
  gz = open("http://data.gharchive.org/2022-01-01-#{hour}.json.gz")
  js = Zlib::GzipReader.new(gz).read

  Yajl::Parser.new.parse(js) do |event|
    GitHub::Event.create(
      event_id: event.fetch('id'),
      type: event.fetch('type'),
      public: event.fetch('public'),
      created_at: event.fetch('created_at')
    )
  end

  time = Time.parse("2022-01-01 #{hour}:00 +0000")
  Rollup::GitHub::Event.call(time)

  progress.increment 
end
