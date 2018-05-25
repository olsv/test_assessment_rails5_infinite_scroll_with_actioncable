class User
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String

  scope :ordered_by, -> (field: :id, direction: :asc, **rest) { order_by(field.to_sym.send(direction)) }
end
