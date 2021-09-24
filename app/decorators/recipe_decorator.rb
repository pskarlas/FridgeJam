# frozen_string_literal: true

# app/decorators/recipe_decorator.rb
class RecipeDecorator
  include ApplicationHelper
  attr_reader :recipe, :view_context

  delegate :id, :nb_comments, :slug, :name, :difficulty, :prep_time, :cook_time, :total_time, :people_quantity, :image, :rate, :budget, :ingredients, :author_tip, to: :recipe

  def initialize(recipe, view_context)
    @recipe, @view_context = recipe, view_context
  end

  def total_time
    @recipe.total_time.to_i
  end

  def image_url
    return view_context.image_path('recipe-placeholder.png') if @recipe.image.blank?
    @recipe.image.to_s
  end

  def rating_badge
    if @recipe.rate.blank?
      view_context.content_tag :span, class: 'uppercase border-2 border-gray-200 rounded-lg px-3 py-1.5 max-w-2xl text-xs text-gray-400 flex items-center font-bold' do
        'no rating'
      end
    else
      view_context.content_tag :span, class: 'border-2 border-sky-100 rounded-lg px-3 py-1.5 max-w-2xl text-sm text-blue-500 flex items-center font-bold' do
        @recipe.rate.to_s
      end
    end
  end

  def dificulty_badge
    case @recipe.difficulty
    when 'très facile'
      view_context.content_tag(:span, 'très facile', class: 'inline-flex items-center px-3 py-0.5 rounded-full text-sm font-medium bg-green-100 text-green-800')
    when 'facile'
      view_context.content_tag(:span, 'facile', class: 'inline-flex items-center px-3 py-0.5 rounded-full text-sm font-medium bg-gray-100 text-gray-800')
    when 'Niveau moyen'
      view_context.content_tag(:span, 'Niveau moyen', class: 'inline-flex items-center px-3 py-0.5 rounded-full text-sm font-medium bg-blue-100 text-blue-800')
    when 'difficile'
      view_context.content_tag(:span, 'difficile', class: 'inline-flex items-center px-3 py-0.5 rounded-full text-sm font-medium bg-pink-100 text-pink-800')
    end
  end
end
