require 'uri'
require 'json'
require 'net/http'
require './Result'
require 'dry/monads/result'

class BigFiveResultsPoster
    include Dry::Monads::Result::Mixin

    EMAIL = "bagaswisnu07@gmail.com"

    def initialize(results_hash, email = EMAIL)
        @email = email
        @hash  = results_hash
    end

    def post
        @hash['EMAIL'] = @email
        uri = URI.parse('https://recruitbot.trikeapps.com/api/v1/roles/senior-team-lead/big_five_profile_submissions')
        http = Net::HTTP.new uri.host, uri.port
        http.use_ssl = true
        request = Net::HTTP::Post.new uri.request_uri, "Content-Type" => "application/json"
        request.body = @hash.to_json

        response = http.request(request)

        Success(response).bind do |res|
            if res.code == 201
                result = {response_code: res.code, token: res.body, error: nil}
                Success(Result.new(result))
            else
                result = {response_code: res.code, token: nil, error: res.body}
                Failure(Result.new(result))
            end
        end
    end
end
