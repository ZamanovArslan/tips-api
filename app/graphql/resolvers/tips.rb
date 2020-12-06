module Resolvers
  class Tips < Resolvers::Base
    argument :title, String, required: false

    type [Types::TipType], null: true

    def fetch_data
      return Tip.where(title: @options[:title]) if @options[:title]

      Tip.all
    end
  end
end
