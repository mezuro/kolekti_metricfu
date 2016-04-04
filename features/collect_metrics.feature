Feature: Collect Ruby metrics
  In order to analyze Ruby source codes
  As a Kolekti user
  I should be able to collect metrics using MetricFu

  @wip @unregister_collectors @clear_repository_dir
  Scenario: Running, parsing and collecting results
    Given MetricFu is registered on Kolekti
    And a persistence strategy is defined
    And I have a set of wanted metrics for all the supported ones
    And the "https://github.com/mezuro/kolekti" repository is cloned
    When I request Kolekti to collect the wanted metrics
    Then there should be hotspot metric results to be saved
    And there should be tree metric results to be saved
    And there should be tree metric results for all the wanted tree metrics
