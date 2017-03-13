class JokeController < ApplicationController

	def index

		@setup = [ "A broken pencil",
					"Cows go"
				 ]
		@punchline = 	[ "Nevermind, it's pointless",
						  "No silly, cows go 'moo'!"
						]

		message_body = params["Body"]
		message_body ||= "just testing"
		from_number = params["From"]
		from_number ||= '7187535492'
		body = message_body.downcase.strip
		if body[-5..-1] == " who?"
			body = body[0..-6]
		end
		def message(to_number, text_body)
			client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
			message = client.messages.create(
			from: "+17185698673",
			to: to_number,
			body: text_body
			)
		end

		if body == 'joke'
			message(from_number, "Knock knock!")
	  	elsif body == "who's there?" || body == "whos there?" || body == "whos there"
			index = rand(@setup.length)
			message(from_number, @setup[index])
		elsif @setup.include?(body)
			index = @setup.index(body)
			message(from_number, @punchline[index])
		elsif body == "just testing"
			message(from_number, "test passed")
		end
		render nothing: true
	end

	private

	def joke_params
      params.permit(:message_body, :from_number)
    end
end
