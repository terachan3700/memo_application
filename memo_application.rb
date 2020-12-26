# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require './models/memo'

before do
  @memo_instance = Memo.instance
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = @memo_instance.select_all
  erb :index
end

get '/memos/new' do
  erb :edit
end

post '/memos' do
  @memo_instance.create(params[:title], params[:memo])
  redirect '/'
  erb :index
end

get '/memos/:id' do |id|
  @memo = @memo_instance.select id
  erb :show
end

get '/memos/:id/edit' do |id|
  @memo = @memo_instance.select id
  erb :edit
end

patch '/memos/:id' do |id|
  @memo_instance.update(id, params[:title], params[:memo])
  redirect '/'
  erb :index
end

delete '/memos/:id' do |id|
  @memo_instance.delete id
  redirect '/'
  erb :index
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end
