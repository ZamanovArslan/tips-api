module Types
  class QueryType < Types::BaseObject
    field :me, resolver: Resolvers::CurrentUser
    field :activities, resolver: Resolvers::Activities, connection: true
    field :tips, resolver: Resolvers::Tips
  end
end
