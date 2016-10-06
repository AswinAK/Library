class ResvNotification < ActionMailer::Base
  default from: "libmanagementapp@gmail.com"

  def sample_email(booked_by,booking, mailid)
    @booking = booking
    @booked_by = booked_by
    puts "In ResvNotification, about to sent mail"
    mail(to: mailid, subject: 'Booking Notification Email')
  end
end
