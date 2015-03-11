require 'logging'

PORTAL_LOG_FILE = 'log/portal_worker.log'

# Define our own log levels
Logging.init :trace, :debug, :info, :warn, :error, :fatal

Logging.logger.root.level = (ENV['LOG_LEVEL'] || :trace).to_sym

# Make the 'log' method available everywhere
include Logging.globally(:log)

# Make sure we're logging in UTC
date_method = 'utc.strftime(\'%F %T %z\')'

layout = Logging.layouts.pattern(date_method: date_method)

Logging.logger.root.appenders = Logging.appenders.file(PORTAL_LOG_FILE, layout: layout)
# Logging.logger.root.appenders = Logging.appenders.stdout(layout: layout)
