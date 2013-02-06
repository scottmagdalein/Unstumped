require 'rubygems'
require 'sinatra'
require 'haml'
require 'stripe'

set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
  haml :index
end

post '/charge' do
	# Amount in cents
  @amount = 24000

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Unstumped Charge',
    :currency    => 'usd',
    :customer    => customer.id
  )

  haml :charge
end

error Stripe::CardError do
  env['sinatra.error'].message
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




