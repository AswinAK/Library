require 'test_helper'

class RoomControllerTest < ActionController::TestCase

  setup do
    @room = room(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room" do
    post :create, room: {room_number: "101", building: "hill", size: "6"}
    assert_response :success
  end

  test "should destroy room" do
    delete :destroy, id: @room
    assert_response :success
  end

end
