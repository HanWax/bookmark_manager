require 'rest_client'

def send_password_reset(email)
	RestClient.post "https://api:key-08222904c429916ed3762b72c122bf49"\
		"@api.mailgun.net/v2/sandbox1963fa8a1a4146c3bac04fd4df7fa6a7.mailgun.org/messages",
		:from => "Mailgun Sandbox <postmaster@sandbox1963fa8a1a4146c3bac04fd4df7fa6a7.mailgun.org>",
		:to => email,
		:subject => "Hello Joe Dowdell",
		:text => "Congratulations Joe Dowdell, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
end


send_password_reset("joedowdell@gmail.com")
