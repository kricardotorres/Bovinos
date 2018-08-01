require 'test_helper'

class CowHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cow_history = cow_histories(:one)
  end

  test "should get index" do
    get cow_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_cow_history_url
    assert_response :success
  end

  test "should create cow_history" do
    assert_difference('CowHistory.count') do
      post cow_histories_url, params: { cow_history: { x: @cow_history.x, y: @cow_history.y, z: @cow_history.z } }
    end

    assert_redirected_to cow_history_url(CowHistory.last)
  end

  test "should show cow_history" do
    get cow_history_url(@cow_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_cow_history_url(@cow_history)
    assert_response :success
  end

  test "should update cow_history" do
    patch cow_history_url(@cow_history), params: { cow_history: { x: @cow_history.x, y: @cow_history.y, z: @cow_history.z } }
    assert_redirected_to cow_history_url(@cow_history)
  end

  test "should destroy cow_history" do
    assert_difference('CowHistory.count', -1) do
      delete cow_history_url(@cow_history)
    end

    assert_redirected_to cow_histories_url
  end
end
