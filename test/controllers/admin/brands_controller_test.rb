require "test_helper"

class Admin::BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_brand = admin_brands(:one)
  end

  test "should get index" do
    get admin_brands_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_brand_url
    assert_response :success
  end

  test "should create admin_brand" do
    assert_difference("Admin::Brand.count") do
      post admin_brands_url, params: { admin_brand: { name: @admin_brand.name } }
    end

    assert_redirected_to admin_brand_url(Admin::Brand.last)
  end

  test "should show admin_brand" do
    get admin_brand_url(@admin_brand)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_brand_url(@admin_brand)
    assert_response :success
  end

  test "should update admin_brand" do
    patch admin_brand_url(@admin_brand), params: { admin_brand: { name: @admin_brand.name } }
    assert_redirected_to admin_brand_url(@admin_brand)
  end

  test "should destroy admin_brand" do
    assert_difference("Admin::Brand.count", -1) do
      delete admin_brand_url(@admin_brand)
    end

    assert_redirected_to admin_brands_url
  end
end
