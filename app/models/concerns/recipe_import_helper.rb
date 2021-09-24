# frozen_string_literal: true

# Helper methods for imprting recipes
module RecipeImportHelper

  def calculate_ttl_cook_time(string)
    return if string.strip.nil? || string.strip.blank?
    arr = extract_time_from(string)
    ttl_mins_from_days  = arr[0] * 1440
    ttl_mins_from_hours = arr[1] * 60
    ttl_mins            = arr[2]

    ttl_mins_from_days + ttl_mins_from_hours + ttl_mins
  end

  def extract_time_from(s)
    s.scan(/(\d{1,2}\s?j)?\s?(\d{1,2}\s?h)?\s?(\d{1,2}\s?)?\s?/)[0].map(&:to_i)
  end
end
