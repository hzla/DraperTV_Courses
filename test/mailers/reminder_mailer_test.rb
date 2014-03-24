require 'test_helper'

class ReminderMailerTest < ActionMailer::TestCase
  test "events_reminder" do
    mail = ReminderMailer.events_reminder
    assert_equal "Events reminder", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
