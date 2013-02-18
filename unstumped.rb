require 'rubygems'
require 'sinatra'
require 'haml'
require 'pony'

# routes #
set :sinatra_authentication_view_path, Pathname(__FILE__).dirname.expand_path + "views/"

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
	@name = params[name]
	@email = params[email]
	@phone = params[phone]
	@what = params[what]
	@experience = params[experience]
	@links = params[links]

	haml :applicant

	options = {
		:to => "scottmagdalein@gmail.com",
		:from => "no-reply@herokuapp.com",
		:reply_to => "#{@email}"
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

__END__
@@layout
!!!
%html
%head
	%title New Method - Become a Web Developer with personal, 1-on-1 training
	%link{ :href => "/stylesheets/style.css", :type => "text/css", :rel => "stylesheet" }
	%link{ :href => "/stylesheets/modal.css", :type => "text/css", :rel => "stylesheet" }
	%link{ :href => "http://fonts.googleapis.com/css?family=Open+Sans:400,800,700|Merriweather:400,900", :rel => "stylesheet", :type => "text/css" }
	%link{ :href => "/fonts/ss-symbolicons-block.css", :rel => "stylesheet", :type => "text/css" }
	%script{ :src => "http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"}
	%script{ :src => "/scripts/jquery.scrollto.js"}
%body
	= yield
