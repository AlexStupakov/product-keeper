require 'sidekiq'
require 'redis'
require 'csv'
require 'open-uri'

class APIWorker
  include Sidekiq::Worker

  $redis = Redis.new

  def perform(msg = "get_api_data")
    $redis.lpush(msg, store_data(remote_csv_text))
  end

  def store_data(csv_text)
    get_data(csv_text).each do |row|
      begin
        Product.create_or_update(row.to_hash)
      rescue => e
        puts "\n--Caught exception #{e}!"
        puts "In the row:\n #{row}\n\n"
      end
    end
  end

  def remote_csv_text
    open(ENV['CSV_URL'])
  end

  def get_data(csv_text)
    CSV.parse(csv_text, :headers=>true, header_converters: :symbol)
  end
end

