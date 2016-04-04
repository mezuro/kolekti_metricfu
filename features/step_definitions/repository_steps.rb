require 'tmpdir'

Given(/^the "([^"]*)" repository is cloned$/) do |arg1|
  @repository_path = Dir.mktmpdir

  expect(system("git", "clone", "-q", repository_url, @repository_path, [:out, :err] => '/dev/null')).to be_truthy
end

