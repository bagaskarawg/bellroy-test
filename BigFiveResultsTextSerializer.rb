class BigFiveResultsTextSerializer
    def initialize(text)
        @text = text
    end

    def to_h
        header = ""
        rows   = @text.split("\n")
        hash   = {"NAME": "Bagaskara Wisnu Gunawan"}

        rows.map do |row|
            splitted_row = row.split('.')
            label        = splitted_row.first
            score        = splitted_row.last

            if label == label.upcase
                header       = label
                hash[header] = {"Overall Score" => score}
            else
                hash[header]['Facets']      ||= Hash.new
                hash[header]['Facets'][label] = score
            end
        end

        hash
    end
end
