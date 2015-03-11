# Portal queue config info.  Needs to work with ruby 1.8.7.
# rubocop:disable Style/HashSyntax
class PortalConfig
  EXCHANGE_NAME = 'portal_exchange'
  EVENT_QUEUE_NAME = 'portal_event_queue'
  WORKER_CONFIG = { :workers => 2,
                    :durable => true,
                    :ack => true }
end
# rubocop:enable Style/HashSyntax
