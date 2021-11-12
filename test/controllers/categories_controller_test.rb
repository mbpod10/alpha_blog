require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
    # @category.save
  end
  
  test "should get index" do
    # @category.save
    get categories_url
    assert_response :success
  end
  
  test "should get new" do
    # @category.save
    get new_category_url
    assert_response :success
  end
  
  test "should create category" do
    assert_difference("Category.count") do
      post categories_url, params: { category: {  } }
    end
  
    assert_redirected_to category_url(Category.last)
  end
  
  test "should show category" do
    # @category.save
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference("Category.count", -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
