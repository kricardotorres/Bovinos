require 'test_helper'

class AlimentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aliment = aliments(:one)
  end

  test "should get index" do
    get aliments_url
    assert_response :success
  end

  test "should get new" do
    get new_aliment_url
    assert_response :success
  end

  test "should create aliment" do
    assert_difference('Aliment.count') do
      post aliments_url, params: { aliment: { name: @aliment.name } }
    end

    assert_redirected_to aliment_url(Aliment.last)
  end

  test "should show aliment" do
    get aliment_url(@aliment)
    assert_response :success
  end

  test "should get edit" do
    get edit_aliment_url(@aliment)
    assert_response :success
  end

  test "should update aliment" do
    patch aliment_url(@aliment), params: { aliment: { name: @aliment.name } }
    assert_redirected_to aliment_url(@aliment)
  end

  test "should destroy aliment" do
    assert_difference('Aliment.count', -1) do
      delete aliment_url(@aliment)
    end

    assert_redirected_to aliments_url
  end
end
