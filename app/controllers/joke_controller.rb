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
		body = message_body.downcase.strip
		from_number = params["From"]
		from_number ||= '7187535492'

		def message(to_number, text_body)
			client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
			message = client.messages.create(
			from: "+15675234372",
			to: to_number,
			body: text_body
			)
		end

		if body == 'joke'
			message(from_number, "Knock knock!")
	  	elsif body == "who's there?" || body == "whos there?" || body == "whos there"
			message(from_number, @setup[0])
		elsif body == @setup[0] + " who?"
			message(from_number, @punchline[0])
		end
		render nothing: true
		# render text: body
	end

	private

	def text_params
      params.permit(:message_body, :from_number)
    end
end
