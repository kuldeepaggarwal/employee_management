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

  def self.grouped_by(type)
    if type.present?
      self_join_arel_table = arel_table.alias('self_join_employees')
      new_scope = \
        scoped.joins(
          arel_table
          .join(self_join_arel_table)
          .on(self_join_arel_table[type].eq(arel_table[type]))
          .join_sources
        ).where(self_join_arel_table[:deleted_at].eq(nil))
        .group(self_join_arel_table[type], arel_table[:id])

      # Need to ensure that self_joins_table's column should be sorted first.
      new_scope.order_values.prepend(self_join_arel_table[type])
      new_scope
    else
      scoped
    end
  end
end
