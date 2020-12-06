module Types
  class TipType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :user, Types::UserType, null: false
    field :anonym, Boolean, null: false
    field :experience, Integer, null: true
    field :experience_extended, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
