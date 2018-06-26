Types::MicropostType = GraphQL::ObjectType.define do
  name "Micropost"
  field :id, !types.ID
  field :content, !types.String
  field :user_id, !types.ID
  field :picture, !types.String
  #field :created_at, !types.Date
end
