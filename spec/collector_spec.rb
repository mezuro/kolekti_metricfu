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

    describe 'collect_metrics' do
      let(:code_directory) { "/tmp/test" }
      let(:output_path) { code_directory + '/metric_fu2843-8392-92849382--0.yml' }
      let(:tempfile) { instance_double(Tempfile) }
      let(:wanted_metric_configurations) { double }
      let(:persistence_strategy) { double }
      let(:metric_fu_params) {
        ['metric_fu', '--format', 'yaml', '--out', output_path, [:out, :err] => '/dev/null']
      }

      before :each do
        expect(Tempfile).to receive(:new).with(['metric_fu', '.yml'], code_directory).and_return(tempfile)
        expect(tempfile).to receive(:close!)
        expect(Dir).to receive(:chdir).with(code_directory).and_yield
      end

      context 'when collecting is successful' do
        it 'is expected collect and parse all metrics' do
          expect(tempfile).to receive(:path).twice.and_return(output_path)
          is_expected.to receive(:system).with(*metric_fu_params).and_return(true)
          expect(KolektiMetricfu::Parsers).to receive(:parse_all).with(output_path, wanted_metric_configurations,
                                                                       persistence_strategy)

          subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        end
      end

      context 'when collecting fails' do
        it 'is expected to raise a Collector Error' do
          expect(tempfile).to receive(:path).once.and_return(output_path)
          is_expected.to receive(:system).with(*metric_fu_params).and_return(false)
          expect(KolektiMetricfu::Parsers).to receive(:parse_all).never

          expect {
            subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
          }.to raise_error(Kolekti::CollectorError, 'MetricFu failed')
        end
      end
    end
  end
end
