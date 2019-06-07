require './BigFiveResultsPoster'
require './BigFiveResultsTextSerializer'

class SubmitResult
    def initialize
        text       = File.read "result.txt"
        serializer = BigFiveResultsTextSerializer.new text
        poster     = BigFiveResultsPoster.new serializer.to_h
        puts poster.post
    end
end

SubmitResult.new
