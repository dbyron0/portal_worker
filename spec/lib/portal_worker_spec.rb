require_relative '../../lib/log_setup'
require 'serverengine'
require 'sneakers'

RSpec.describe 'PortalWorker' do
  context 'work' do
    before do
      @worker_pid = Process.spawn('bin/event_worker')
    end

    after do
      unless @worker_pid.nil?
        Process.kill(ServerEngine::Daemon::Signals::GRACEFUL_STOP, @worker_pid)
        _pid, status = Process.wait2(@worker_pid)
        expect(status.exitstatus).to eq(0)
      end
    end

    describe 'with an empty queue' do
      it 'does nothing' do
        # We need to do something to at least make sure it comes up...What's
        # involved in waiting for the actual workers (as opposed to the
        # supervisor) are up?
        sleep 1
        p "hello after no-op: worker_pid: '#{@worker_pid}'"
      end
    end
  end
end
