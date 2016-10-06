class BookingController < ApplicationController
  
  before_filter :authenticateUser!
  def index
  end

  def show
    #show all the bookings of  a particular room
    @all_bookings=Booking.where(:room_number=>params[:id])
    @showing_for_room=params[:id]
    
  end

  def book
    @booking_status = params[:id5]
    @slot=params[:id3]
    @date=params[:id4]
    @room_num=params[:id]
    if(@booking_status=="booked")
      booking=Booking.where(:slot => @slot,:date => @date, :room_number =>@room_num).first
     
      @booking_id=booking.id
      @booking_member_id=booking.email_id
      @booking_member_name= Member.find_by(:id=>@booking_member_id).first_name
     
    else
     #check if the same user has already booked another room for the same time and slot
      puts "Current user ID : ",params[:id2]
      booking=Booking.where(:slot => @slot,:date => @date, :email_id =>params[:id2])
      if(booking.count>0 && !(Member.where(:id=> params[:id2]).first.permitted))
        
        #user has already booked the room for the same time and date
        flash[:notice]="You already have booked a room for the same time and date.Kindly delete that reservation first or get permit from admin to book multiple rooms"
        redirect_to :action => "show_availability", :id=>@room_num
      end
    end
  end

  def search

  end

  def confirmbooking
   
    if(session[:admin])

      foundMember=Member.find_by(:email_id=> params[:name])
      #search for the mail id in the database to see if the user exists:
      if(Member.find_by(:email_id=> params[:name]).present?)
        #delete the old booking first BEFORE saving the new booking with the new user that admin entered
         @deleted_booking = Booking.find_by(:id=>params[:booking_id])
         if(@deleted_booking.present?)
            @deleted_booking.destroy
         end
        #adding the booking
        booking = Booking.new
        booking.email_id = foundMember.id
        booking.room_number = params[:id]
        booking.slot = params[:id3]
        booking.date = params[:id4]
        booking.save

        # Change for email functionality
       
        emails = params[:emailids].split(';')
        emails << params[:name]
        puts params[:emailids]
        puts emails.inspect

        emails.each do |to_address|  
          
          ResvNotification.sample_email(session[:userName],booking,to_address).deliver
        end
       
        # Change ends

        redirect_to :action=>"show_availability", :id=>params[:id]

      else
        flash[:notice]="No such user exists, try valid email id"
        bookedRoom = Booking.find_by(:id=>params[:id])
        redirect_to :action => "book", :id=>params[:id], :id2=>params[:id2], :id3=>params[:id3], :id4=>params[:id4], :id5=>"available"

      end
    else
      booking = Booking.new
      booking.email_id = params[:id2]
      booking.room_number = params[:id]
      booking.slot = params[:id3]
      booking.date = params[:id4]
      booking.save
      # Change for email functionality
        puts "in booking controller, about to call email"
        emails = params[:emailids].split(';')
      
        emails << params[:name]  

        emails.each do |to_address|  
       
          ResvNotification.sample_email(session[:userName],booking,to_address).deliver
        end

      # Change ends

      redirect_to :action=>"show_availability", :id=>params[:id]

    end


  end
  def list
    
    loc = params[:location].to_s
    cap = params[:capacity].to_s
    room= params[:room_number_to_search].to_s
   
    if(cap.size==0&&loc.size==0&&room.size==0)
      @rooms = Room.all

    elsif(cap.size!=0&&loc.size==0&&room.size==0)
      @rooms =Room.where(:size=> params[:capacity])
    elsif(cap.size==0&&loc.size!=0&&room.size==0)
      @rooms =Room.where(:building=> params[:location])
    elsif(cap.size==0&&loc.size==0&&room.size!=0)
      @rooms =Room.where(:room_number=> params[:room_number_to_search])

    elsif(cap.size!=0&&loc.size!=0&&room.size==0)
      @rooms =Room.where(:building=>params[:location]).where(:size=> params[:capacity])
    elsif(cap.size==0&&loc.size!=0&&room.size!=0)
      @rooms =Room.where(:room_number=> params[:room_number_to_search]).where(:building=>params[:location])
    elsif(cap.size!=0&&loc.size==0&&room.size!=0)
      @rooms =Room.where(:room_number=> params[:room_number_to_search]).where(:size=> params[:capacity])

    else
      @rooms =Room.where(:room_number=> params[:room_number_to_search]).where(:size=> params[:capacity]).where(:building=>params[:location])
    end



  end

  def show_availability
    @current_room_id =params[:id]
    @current_date = Date.current
    @current_user_id = session[:userid]

    @slots_array =[]

    @bookings= Booking.where(room_number: params[:id])
    availablity=nil
    for date in Date.current..(Date.current+6)
   
      for slot in 1..8
   


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
  

  end


  def view_bookings
   
    @bookings = Booking.where(email_id: params[:id])
    @member_id= params[:id]
  end

  def delete
    del_id = params[:id]
 
    b= Booking.find_by(id: del_id)
    b.destroy
    if(params[:id2]=="Room")
      redirect_to action: "show", :id=>params[:room_number]
    else
      redirect_to action: "view_bookings" ,:id=>params[:member_id]
    end
  end

end
#/Users/AswinAk/Documents/Rails/LATEST/LibraryPortal/app/controllers/booking_controller.rb
