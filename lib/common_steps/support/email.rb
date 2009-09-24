require "rumbster"
require "message_observers" # same gem as rumbster

rumbster = nil
Before do
  rumbster = Rumbster.new(ActionMailer::Base.smtp_settings[:port])
  @email_inbox = MailMessageObserver.new
  rumbster.add_observer @email_inbox
  rumbster.start
end

After do
  rumbster.stop
end
