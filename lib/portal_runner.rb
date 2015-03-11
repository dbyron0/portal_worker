require 'logger'
require 'sneakers/runner'
require_relative 'log_setup'
require_relative 'portal_config'

# Make it easy to configure and run worker(s)
class PortalRunner
  def initialize(worker_class)
    config_params = { amqp: ENV['AMQP_URL'], daemonize: false, log: PORTAL_LOG_FILE }.merge(PortalConfig::WORKER_CONFIG)
    Sneakers.configure(config_params)
    Sneakers.logger.level = Logger::INFO
    @runner = Sneakers::Runner.new([worker_class])
  end

  def run
    @runner.run
  end

  def stop
    @runner.stop
  end
end
