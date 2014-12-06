module Sort
  extend ActiveSupport::Concern

  module ClassMethods
    def sort_order(column = nil, direction = nil, default_column = nil, default_dir = nil)
      column ||= default_column
      order(column ? "#{ column } #{ sort_direction(direction, default_dir) }" : nil)
    end

    private
      def sort_direction(direction, default_dir = nil)
        default_dir ||= 'asc'
        %w[asc desc].include?(direction.to_s.downcase) ? direction : default_dir
      end
  end
end
