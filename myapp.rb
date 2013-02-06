require 'rubygems'
require 'sinatra'
require 'haml'


get '/' do
  haml :index
end

post '/form' do
	@one = params["one"]

	options = {
		:to => "#{@email}",
		:cc => "#{@spouse_email}",
		:from => "no-reply@herokuapp.com",
		:subject => "You finished Redefining Love at ArtOfUs",
		# :body => "This is plain text.",
		:html_body => (haml :template),
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
end

__END__
@@layout
!!!
%html
%head
	%title Unstumped - Get 1-on-1 help with HTML, CSS, JavaScript, and Ruby
	%link{ :href => "/stylesheets/style.css", :type => "text/css", :rel => "stylesheet" }
	%link{ :href => "/stylesheets/modal.css", :type => "text/css", :rel => "stylesheet" }
	%link{ :href => "http://fonts.googleapis.com/css?family=Open+Sans:400,800,700|Merriweather:400,900", :rel => "stylesheet", :type => "text/css" }
%body
	= yield
