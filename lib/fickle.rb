require 'faraday'
require 'multi_json'

module Fickle
  class Client
    USERNAME = 'fickle'
    MIME_TYPE = 'application/json'

    attr_reader :host, :password

    def initialize(host, password = nil)
      @host = host
      @password = password
    end

    def self.connection(url, password = nil)
      Faraday.new(url) do |builder|
        if !password.nil?
          builder.use Faraday::Request::BasicAuthentication, USERNAME, password
        end

        builder.headers['Content-Type'] = MIME_TYPE
        builder.use Faraday::Response::RaiseError

        builder.adapter Faraday.default_adapter
      end
    end

    def connection
      @connection ||= self.class.connection(host, password)
    end

    def load(dataset)
      post('/load', encode(dataset))
      true
    end

    def fit
      post('/fit')
      true
    end

    def validate
      response = post('/validate')
      decode(response)
    end

    def predict(samples, probabilities = false)
      path = '/predict'
      path += '/probabilities' if probabilities

      response = post(path, encode(samples))
      decode(response)
    end

    def recommend(keys, n = nil)
      response = connection.post('/recommend') do |req|
        req.params['n'] = Integer(n) if n
        req.body = encode(keys)
      end
      decode(response)
    end

    private
    def post(url, body = nil)
      connection.post(url, body)
    end

    def encode(body)
      MultiJson.encode(body)
    end

    def decode(response)
      MultiJson.decode(response.body)
    end
  end
end
