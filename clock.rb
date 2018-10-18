require 'clockwork'
require_relative './application'


module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.day, 'midnight.job', :at => '00:00') { APIWorker.perform_async }
end
