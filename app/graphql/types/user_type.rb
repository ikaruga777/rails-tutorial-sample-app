module Types
    UserType = GraphQL::ObjectType.define do
      name "User"
      description "ユーザ情報だよ"
      field :id, !types.ID
      field :name, !types.String
      field :email, !types.String
      connection :microposts, MicropostType.connection_type
      connection :following, UserType.connection_type
      connection :followers, UserType.connection_type
  end
end
