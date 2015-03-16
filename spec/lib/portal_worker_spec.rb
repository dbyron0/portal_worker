require_relative '../../lib/log_setup'
require 'English'
require 'serverengine'
require 'sneakers'

RSpec.describe 'PortalWorker' do
  context 'work' do
    before do
      log.info 'spawning worker'
      @worker_pid = Process.spawn('bin/event_worker')
      log.info "spawned worker with pid '#{@worker_pid}"
    end

    after do
      unless @worker_pid.nil?
        # If we don't get a response in a reasonable number of seconds...give up
        begin
          Timeout.timeout(5) do
            log.info "stopping worker with pid '#{@worker_pid}'"
            Process.kill(ServerEngine::Daemon::Signals::GRACEFUL_STOP, @worker_pid)
            _pid, status = Process.wait2(@worker_pid)
            log.info "worker with pid '#{@worker_pid}' stopped"
            expect(status.exitstatus).to eq(0), "expected #{@worker_pid} to stop with exit code 0, got '#{status.exitstatus}'"
          end
        rescue Timeout::Error
          msg = "timeout processing worker with pid '#{@worker_pid}'"
          log.error msg
          raise $ERROR_INFO, msg, $ERROR_INFO.backtrace
        end
      end
    end

    # 0.1 to 0.4 is 'too fast' on my local machine.  wait2 returns nil in these
    # cases...not an actual exit status.
    (5..10).each do |i|
      startup_delay = i * 0.1
      describe "with an empty queue (startup delay #{startup_delay})" do
        it 'does nothing' do
          # We need to do something to at least make sure it comes up...What's
          # involved in waiting for the actual workers (as opposed to the
          # supervisor) are up?
          sleep startup_delay
          p "hello after #{startup_delay} seconds: worker_pid: '#{@worker_pid}'"
        end
      end
    end
  end
end
