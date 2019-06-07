require 'dry-struct'

module Types
    include Dry::Types()
end

class Result < Dry::Struct
    attribute :error, Types::Strict::String.optional
    attribute :token, Types::Strict::String.optional
    attribute :response_code, Types::Coercible::Integer
end
