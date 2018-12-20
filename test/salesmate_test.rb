require 'test_helper'

class SalesmateTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Salesmate::VERSION
  end
end
