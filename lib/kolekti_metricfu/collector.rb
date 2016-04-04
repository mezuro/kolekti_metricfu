module KolektiMetricfu
  class Collector < Kolekti::Collector
    def self.available?
      system('metric_fu --version', [:out, :err] => '/dev/null') ? true : false
    end
  end
end
