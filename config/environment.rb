ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'rubygems'
require 'pg'
require 'pathname'
require 'uri'
require 'active_record'
require 'logger'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sidekiq'
require 'twitter'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
CONFIG   = Pathname.new(File.expand_path("#{APP_ROOT}/config"))
APP_NAME = APP_ROOT.basename.to_s

Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

require APP_ROOT.join('config', 'database')   # db
require APP_ROOT.join('config', 'initialize') # keys
