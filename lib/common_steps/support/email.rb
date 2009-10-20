require "rumbster"
require "message_observers" # same gem as rumbster

rumbster = nil
Before do
  selenium rescue nil # load up selenium before listening to smtp port, otherwise the selenium process will inherit the open file descriptors
  rumbster.stop unless rumbster.nil?
  rumbster = Rumbster.new(ActionMailer::Base.smtp_settings[:port])
  @email_inbox = MailMessageObserver.new
  rumbster.add_observer @email_inbox
  rumbster.start
end
