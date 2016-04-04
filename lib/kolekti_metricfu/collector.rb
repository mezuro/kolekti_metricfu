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
  end
end
