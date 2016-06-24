class TestMailer < ActionMailer::Base
  def test_email
    @recipients = "eggandcheesesandwich@gmail.com"
    @from = "eggandcheesesandwich@gmail.com"
    @subject = "test from the Rails Console"
    @body = "This is a test email"
  end
end
