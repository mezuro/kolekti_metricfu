require 'spec_helper'

describe KolektiMetricfu::Collector do
  describe 'class method' do
    describe 'available?' do
      context 'with a successful call (system exit 0)' do
        it 'is expected to call the system executable and return true' do
          expect(described_class).to receive(:system).with('metric_fu --version', [:out, :err] => '/dev/null') { true }

          expect(described_class.available?).to be_truthy
        end
      end

      context 'with a failed call to system executable (it is not installed)' do
        it 'is expected to call the system executable and return false' do
          expect(described_class).to receive(:system).with('metric_fu --version', [:out, :err] => '/dev/null') { nil }

          expect(described_class.available?).to be_falsey
        end
      end

      context 'with a errored call to system executable (it is installed but not working: non-zero exit)' do
        it 'is expected to call the system executable and return false' do
          expect(described_class).to receive(:system).with('metric_fu --version', [:out, :err] => '/dev/null') { false }

          expect(described_class.available?).to be_falsey
        end
      end
    end
  end

  describe 'instance method' do
    describe 'initialize' do
      let(:supported_metrics) { double }

      it 'is expected to load the supported metrics' do
        expect_any_instance_of(described_class).to receive(:parse_supported_metrics).with(
          /\/metrics\.yml$/, 'MetricFu', [:RUBY]) { supported_metrics }

        subject = described_class.new
        expect(subject.supported_metrics).to eq(supported_metrics)
      end
    end
  end
end