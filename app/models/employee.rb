class Employee < ActiveRecord::Base
  include Sort
  include MatchScope
  acts_as_paranoid

  # Whitelist Attributes
  attr_accessible :age, :department, :designation, :email_id, :location, :name

  # Validations
  validates :name, :age, :email_id, :designation, :location, presence: true
  validates :email_id, uniqueness: { case_sensitive: false }, allow_blank: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

  def self.search(term)
    term.present? ? match_all(term) : scoped
  end
end
