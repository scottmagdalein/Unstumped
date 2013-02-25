require 'rubygems'
require 'sinatra'
require 'haml'
require 'pony'
require 'nesta'
require 'nesta/app'

# routes #

class SinatraApp < Sinatra::Base

	get '/' do
	  haml :index
	end

	get '/pay' do
		haml :pay
	end

	get '/hooray' do
		haml :hooray
	end

	get '/sadface' do
		haml :sadface
	end

	post '/apply' do
		@name = params["name"]
		@email = params["email"]
		@phone = params["phone"]
		@what = params["what"]
		@experience = params["experience"]
		@links = params["links"]

		options = {
			:to => "scottmagdalein@gmail.com",
			:from => "no-reply@herokuapp.com",
			:reply_to => "#{@email}",
			:subject => "New applicant: #{@name}",
			:html_body => haml(:applicant),
			:via => :smtp,
			:via_options => {
				:address => 'smtp.mandrillapp.com',
				:port => '587',
				:enable_starttls_auto => true,
				:user_name => 'scottmagdalein@gmail.com',
				:password => '6xNf32J0tIlqgqW_epr3Kg',
				:authentication => :plain,
				:domain => "herokuapp.com"
			}
		}

		Pony.mail(options)

		haml :success
	end

end
