Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :user, !Types::UserType do
    resolve ->(obj, args, ctx) {
      ctx[:current_user]
    }
  end
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end
end
