class User
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String

  paginates_per 25

  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, with: /.+\@.+\..+/, if: -> { email.present? }

  scope :ordered_by, -> (field: :id, direction: :asc, **rest) { order_by(field.to_sym.send(direction)) }
end
