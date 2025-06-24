require "application_system_test_case"

class Admin::BrandsTest < ApplicationSystemTestCase
  setup do
    @admin_brand = admin_brands(:one)
  end

  test "visiting the index" do
    visit admin_brands_url
    assert_selector "h1", text: "Brands"
  end

  test "should create brand" do
    visit admin_brands_url
    click_on "New brand"

    fill_in "Name", with: @admin_brand.name
    click_on "Create Brand"

    assert_text "Brand was successfully created"
    click_on "Back"
  end

  test "should update Brand" do
    visit admin_brand_url(@admin_brand)
    click_on "Edit this brand", match: :first

    fill_in "Name", with: @admin_brand.name
    click_on "Update Brand"

    assert_text "Brand was successfully updated"
    click_on "Back"
  end

  test "should destroy Brand" do
    visit admin_brand_url(@admin_brand)
    click_on "Destroy this brand", match: :first

    assert_text "Brand was successfully destroyed"
  end
end
