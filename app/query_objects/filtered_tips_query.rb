class FilteredTipsQuery < BaseFilteredQuery
  ALLOWED_PARAMS = [:title, :keyword].freeze
  TITLE_QUERY = <<~SQL.squish
    title ILIKE :query
  SQL
  SEARCH_QUERY = <<~SQL.squish
    lower(tips.title) SIMILAR TO lower(:keyword) ESCAPE '^' OR
    lower(tips.description) SIMILAR TO lower(:keyword) ESCAPE '^'
  SQL

  def by_title(relation, title)
    relation.where(TITLE_QUERY, query: prepare_query_to_ilike_search(title))
  end

  def by_keyword(relation, keyword)
    relation.where(SEARCH_QUERY, keyword: prepare_query_to_search(keyword))
  end
end
