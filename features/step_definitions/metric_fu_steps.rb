Given(/^MetricFu is registered on Kolekti$/) do
  Kolekti.register_collector(KolektiMetricfu::Collector)
end
