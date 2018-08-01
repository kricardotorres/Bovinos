require 'test_helper'

class ArduinoDevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @arduino_device = arduino_devices(:one)
  end

  test "should get index" do
    get arduino_devices_url
    assert_response :success
  end

  test "should get new" do
    get new_arduino_device_url
    assert_response :success
  end

  test "should create arduino_device" do
    assert_difference('ArduinoDevice.count') do
      post arduino_devices_url, params: { arduino_device: { chipid: @arduino_device.chipid, model: @arduino_device.model } }
    end

    assert_redirected_to arduino_device_url(ArduinoDevice.last)
  end

  test "should show arduino_device" do
    get arduino_device_url(@arduino_device)
    assert_response :success
  end

  test "should get edit" do
    get edit_arduino_device_url(@arduino_device)
    assert_response :success
  end

  test "should update arduino_device" do
    patch arduino_device_url(@arduino_device), params: { arduino_device: { chipid: @arduino_device.chipid, model: @arduino_device.model } }
    assert_redirected_to arduino_device_url(@arduino_device)
  end

  test "should destroy arduino_device" do
    assert_difference('ArduinoDevice.count', -1) do
      delete arduino_device_url(@arduino_device)
    end

    assert_redirected_to arduino_devices_url
  end
end
