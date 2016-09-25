class BookingController < ApplicationController
  def index
  end

  def book

  end

  def search

  end

  def confirmbooking
    puts "In confirmbooking: P1 is "+params[:id].to_s
    booking = Booking.new
    booking.email_id = params[:id2]
    booking.room_number = params[:id]
    booking.slot = params[:id3]
    booking.date = params[:id4];
    booking.save
    redirect_string = "show_availability/"+params[:id]
    #flash[:success] = "Your booking is confirmed":id
    redirect_to action: redirect_string

  end

  def list
    puts "Location: "+params[:location]
    puts "Size: "+params[:capacity]

    @rooms =Room.where(building: params[:location]).where(size: params[:capacity])
  end

  def show_availability
    @current_room_id =params[:id]
    @current_date = Date.current
    @current_user_id = session[:userid]

    @slots_array =[]

    @bookings= Booking.where(room_number: params[:id])
    availablity=nil
    for date in Date.current..(Date.current+6)
      puts "Date: "+date.to_s
      for slot in 1..8
        puts "Slot: "+slot.to_s


        b= Booking.where(date: date, slot: slot, room_number: params[:id])
        #puts "count: "+b.count.to_s

        if b.count > 0
          availablity = "booked"
        else
          availablity= "available"
        end

        hash= {:date => date, :slot => slot, :status => availablity}
        @slots_array.push(hash)
      end
    end
    puts "Availability Array "+@slots_array.inspect

  end

end