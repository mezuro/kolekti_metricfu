require 'tempfile'

module KolektiMetricfu
  class Collector < Kolekti::Collector
    def self.available?
      system('metric_fu --version', [:out, :err] => '/dev/null') ? true : false
    end

    def initialize
      supported_metrics = parse_supported_metrics(
        File.expand_path('../metrics.yml', __FILE__),
        'MetricFu',
        [:RUBY]
      )

      super('MetricFu', 'Set of Ruby metric tools', supported_metrics)
    end

    def collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
      tmp_file = Tempfile.new(['metric_fu', '.yml'], code_directory)
      begin
        Dir.chdir(code_directory) do
          unless system(['metric_fu', '--format', 'yaml', '--out', tmp_file.path], [:out, :err] => '/dev/null')
            raise Kolekti::CollectorError.new('MetricFu failed')
          end
        end
        KolektiMetricfu::Parsers.parse_all(tmp_file.path, wanted_metric_configurations, persistence_strategy)
      ensure
        tmp_file.close!
      end
    end
  end
end
