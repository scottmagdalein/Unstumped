require 'rubygems'
require 'bundler/setup'
require 'nesta/env'
Nesta::Env.root = ::File.expand_path('blog', ::File.dirname(__FILE__))
require 'nesta/app'
require './newmethod'

Bundler.require(:default)

use Rack::ShowExceptions
use Rack::CommonLogger
use Rack::ConditionalGet
use Rack::ETag

app = Rack::Builder.new do
	use Rack::CommonLogger

	map '/blog' do
		run Nesta::App
	end

	map '/' do
		run SinatraApp
	end
end.to_app

run app