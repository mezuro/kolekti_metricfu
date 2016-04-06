module KolektiMetricfu
  module Parsers
    class Base < Kolekti::Parser
      def self.module_name_suffix(module_name)
        return '' if module_name.to_s.end_with?("#none")
        # Removing the self part of a static method to conform to flog's standard
        return "." + module_name.to_s.gsub(/self\./, "").gsub(/#|::/, ".")
      end
    end
  end
end
