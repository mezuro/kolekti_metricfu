module KolektiMetricfu
  module Parsers
    class Flay < Base
      def self.parse(collected_metrics_hash, metric_configuration, persistence_strategy)
        collected_metrics_hash[:matches].each do |match|
          results = []
          reason = match[:reason]
          hotspot_metric_results = match[:matches].map do |line_match|
            line_number = line_match[:line].to_i
            module_name = parse_file_name(line_match[:name])
            results << { 'module_name' => module_name,
                         'line' => line_number,
                         'message' => reason }
          end

          persistence_strategy.create_hotspot_metric_results(metric_configuration, results) unless results.empty?
        end
      end
    end
  end
end
