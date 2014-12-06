module MatchScope
  extend ActiveSupport::Concern

  module ClassMethods
    def match(matchers)
      clauses = matchers.map do |attribute, conditions|
        Array.wrap(conditions).map do |predicates|
          predicates = { eq: predicates } unless predicates.kind_of?(Hash)
          predicates.map do |predicate, value|
            arel_table[attribute].send(predicate, value)
          end.reduce(:and)
        end.reduce(:or)
      end.reduce(:or)
      where(clauses)
    end

    def match_all(term)
      term = "%#{ sanitize_sql_like term }%"
      match(Hash[self.searchable_columns.collect do |column|
        [column.name, { matches: term }]
      end])
    end

    def searchable_columns
      self.columns.select do |column|
        %w(id deleted_at).exclude?(column.name)
      end
    end

    # Sanitizes a +string+ so that it is safe to use within a sql
    # LIKE statement. This method uses +escape_character+ to escape all occurrences of "\", "_" and "%"
    def sanitize_sql_like(string, escape_character = "\\")
      string.gsub(/[\\_%]/) { |match| [escape_character, match].join }
    end
  end
end
