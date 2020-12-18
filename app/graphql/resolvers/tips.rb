module Resolvers
  class Tips < Resolvers::Base
    argument :title, String, required: false
    argument :keyword, String, required: false

    type [Types::TipType], null: true

    def fetch_data
      FilteredTipsQuery.new(base_data, options).all
    end

    def base_data
      Tip.all
    end
  end
end
