require_relative 'portal_config'
require 'sneakers'

# Process queued events
class PortalEventWorker
  include Sneakers::Worker
  from_queue PortalConfig::EVENT_QUEUE_NAME

  def work(msg)
    p "#{caller(0)[0]}: '#{msg}'"
    worker_trace msg
    ack!
  end
end
