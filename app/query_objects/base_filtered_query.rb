class BaseFilteredQuery
  def initialize(relation, filter_params = {})
    @relation = relation
    @filter_params = filter_params
  end

  def all
    filter_params.reduce(relation) do |relation, (key, value)|
      public_send("by_#{key}", relation, value)
    end
  end

  private

  attr_reader :relation, :filter_params

  def prepare_query_to_ilike_search(query)
    "%#{query}%"
  end

  def prepare_query_to_search(query)
    [
      "%(",
      query.gsub(/[^[:ascii:]]/, " ").gsub(/([^\w\s])/, '^\1').split(" ").join("|").downcase,
      ")%"
    ].join
  end
end
