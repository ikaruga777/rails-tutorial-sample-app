Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :name, !types.String
  field :email, !types.String
  connection :microposts, !Types::MicropostType.connection_type
end
