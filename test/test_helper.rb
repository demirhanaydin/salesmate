$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'salesmate'

require 'minitest/autorun'
require 'minitest/reporters'
require 'webmock/minitest'

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(color: true)
# Disable all network requests for the sake of tests
WebMock.disable_net_connect!
