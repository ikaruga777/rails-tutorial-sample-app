Types::DateTimeType = GraphQL::ScalarType.define do
  name "DateTime"
  coerce_input -> (input_value, context) { Time.zone.parse(input_value) }
  coerce_result -> (ruby_value, context) { ruby_value.utc.iso8601 }
end