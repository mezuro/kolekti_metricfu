require 'kolekti_metricfu/parsers/base'
require 'kolekti_metricfu/parsers/flog'
require 'kolekti_metricfu/parsers/saikuro'
require 'kolekti_metricfu/parsers/flay'

module KolektiMetricfu
  module Parsers
    PARSERS = {
      flog: Flog,
      saikuro: Saikuro,
      flay: Flay
    }

    def self.parse_all(results_yaml_path, wanted_metric_configurations, persistence_strategy)
      parsed_result = YAML.load_file(results_yaml_path)

      wanted_metric_configurations.each do |code, metric_configuration|
        code_sym = code.to_sym
        PARSERS[code_sym].parse(parsed_result[code_sym], metric_configuration, persistence_strategy)
      end
    end
  end
end
