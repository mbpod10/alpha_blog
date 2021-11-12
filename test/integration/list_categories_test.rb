require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Hockey")
  end

  # AFTER SETUP, GO TO THE CATEGORIES INDEX PAGE AND SEE
  # IF THERE ARE <a href="/categories/:id"> SELECTOR ON PAGE
  # AND SEE IF THE HTML TEXT IS THE SAME AS THE NAME OF CATEGORIES
  # THAT WE CREATED IN THE SETUP 
  test "should show categories listing" do
    get "/categories"
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name    
  end

  test "viewing the categories index" do
    get "/categories"
    assert_response :success
    assert_match "Categories", response.body
    assert_match "Sports", response.body
  end
end
