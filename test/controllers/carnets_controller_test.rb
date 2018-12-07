require 'test_helper'

class CarnetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @carnet = carnets(:one)
  end

  test "should get index" do
    get carnets_url
    assert_response :success
  end

  test "should get new" do
    get new_carnet_url
    assert_response :success
  end

  test "should create carnet" do
    assert_difference('Carnet.count') do
      post carnets_url, params: { carnet: { aplication_date: @carnet.aplication_date, earing_inf: @carnet.earing_inf, earing_sup: @carnet.earing_sup, vacune: @carnet.vacune, weight: @carnet.weight } }
    end

    assert_redirected_to carnet_url(Carnet.last)
  end

  test "should show carnet" do
    get carnet_url(@carnet)
    assert_response :success
  end

  test "should get edit" do
    get edit_carnet_url(@carnet)
    assert_response :success
  end

  test "should update carnet" do
    patch carnet_url(@carnet), params: { carnet: { aplication_date: @carnet.aplication_date, earing_inf: @carnet.earing_inf, earing_sup: @carnet.earing_sup, vacune: @carnet.vacune, weight: @carnet.weight } }
    assert_redirected_to carnet_url(@carnet)
  end

  test "should destroy carnet" do
    assert_difference('Carnet.count', -1) do
      delete carnet_url(@carnet)
    end

    assert_redirected_to carnets_url
  end
end
