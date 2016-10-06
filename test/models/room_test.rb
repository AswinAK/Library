require 'test_helper'

class RoomTest < ActiveSupport::TestCase


      test "room not saved without information" do
        @room = Room.create()
        assert_not @room.save, "Cant save room without room no, building and size"
      end

      test "room saves successfully with information" do
        @room = Room.create(room_number: "101", building: "ABC", size: "6")
        assert @room.save, "room created successfully"
      end

      test "room not saves without room_number" do
        @room = Room.create(building: "ABC", size: "6")
        assert_not @room.save, "can not create room without room number"
      end

      test "room not saves without building" do
        @room = Room.create(size: "6")
        assert_not @room.save, "can not create room without building"
      end
end
