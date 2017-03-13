class JokeController < ApplicationController
	def index

		@setup = [ "A broken pencil",
					"Cows go",
					"Canoe",
					"Justin",
					"Abby",
					"Tank",
					"Watson",
					"Spell"
				 ]
		@punchline = [ "Nevermind, it's pointless.",
					   "No silly, cows go 'moo'!",
					   "Canoe help me with my homework?",
					   "Justin time for dinner.",
					   "Abby birthday to you!",
					   "You're welcome!",
					   "What's on tv tonight?",
					   "W-H-O"
						]

		message_body = params["Body"]
		from_number = params["From"]
		body = message_body.downcase.strip.capitalize
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

		if body == 'Joke'
			message(from_number, "Knock knock!")
		elsif body == "Who's there?" || body == "Whos there?"
			index = rand(@setup.length)
			message(from_number, @setup[index])
		elsif @setup.include?(body)
			index = @setup.index(body)
			message(from_number, @punchline[index])
		end
		render nothing: true
	end

	private

	def joke_params
      params.permit(:message_body, :from_number)
    end
end
