require 'test_helper'

class Salesmate::ClientTest < Minitest::Test
  def options
    {
      base_url: 'https://fbrktrdev.salesmate.io',
      app_private_key: 'foo',
      session_token: 'bar',
      app_access_key: 'baz'
    }
  end

  def sample_client
    Salesmate::Client.new(options)
  end

  def test_initialize_with_options
    client = sample_client
    assert_equal options[:base_url], client.base_url
    assert_equal options[:app_private_key], client.app_private_key
    assert_equal options[:session_token], client.session_token
    assert_equal options[:app_access_key], client.app_access_key
  end

  def test_method_missing_check
    skip 'not implemented yet'
  end

  def test_connection_has_headers
    client = sample_client
    assert_equal 'application/json', client.connection.headers['Content-Type']
    assert_equal options[:app_private_key], client.connection.headers['AppPrivateKey']
    assert_equal options[:session_token], client.connection.headers['SessionToken']
    assert_equal options[:app_access_key], client.connection.headers['AppAccessKey']
    assert_match %r{Salesmate Ruby SDK/.+ Faraday/.+}, client.connection.headers['User-Agent']
  end
end
