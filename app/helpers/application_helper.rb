# frozen_string_literal: true

# app/helpers/application_helper.rb
module ApplicationHelper
  # Inline SVG helper
  def svg(filename, options = {})
    file_path = "#{Rails.root}/app/assets/svgs/#{filename}.svg"
    if File.exist?(file_path)
      file = File.read(file_path).html_safe
      doc  = Nokogiri::HTML::DocumentFragment.parse file
      svg  = doc.at_css 'svg'
      if options[:class].present?
        svg['class'] = options[:class]
      end
      if options[:style].present?
        svg[:style] = options[:style]
      end
      raw doc
    else
      '(not found)'
    end
  end
end
