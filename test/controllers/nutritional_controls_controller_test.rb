require 'test_helper'

class NutritionalControlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nutritional_control = nutritional_controls(:one)
  end

  test "should get index" do
    get nutritional_controls_url
    assert_response :success
  end

  test "should get new" do
    get new_nutritional_control_url
    assert_response :success
  end

  test "should create nutritional_control" do
    assert_difference('NutritionalControl.count') do
      post nutritional_controls_url, params: { nutritional_control: { from_date: @nutritional_control.from_date, name: @nutritional_control.name, purpouse: @nutritional_control.purpouse, to_date: @nutritional_control.to_date } }
    end

    assert_redirected_to nutritional_control_url(NutritionalControl.last)
  end

  test "should show nutritional_control" do
    get nutritional_control_url(@nutritional_control)
    assert_response :success
  end

  test "should get edit" do
    get edit_nutritional_control_url(@nutritional_control)
    assert_response :success
  end

  test "should update nutritional_control" do
    patch nutritional_control_url(@nutritional_control), params: { nutritional_control: { from_date: @nutritional_control.from_date, name: @nutritional_control.name, purpouse: @nutritional_control.purpouse, to_date: @nutritional_control.to_date } }
    assert_redirected_to nutritional_control_url(@nutritional_control)
  end

  test "should destroy nutritional_control" do
    assert_difference('NutritionalControl.count', -1) do
      delete nutritional_control_url(@nutritional_control)
    end

    assert_redirected_to nutritional_controls_url
  end
end
