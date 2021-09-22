require 'rails_helper'

RSpec.describe "ingredients/index", type: :view do
  before(:each) do
    assign(:ingredients, [
      Ingredient.create!(
        recipe: nil
      ),
      Ingredient.create!(
        recipe: nil
      )
    ])
  end

  it "renders a list of ingredients" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
