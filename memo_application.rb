# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require './models/data_file'

get '/' do
  @memos = DataFile.read_csv_data
  erb :index
end

get '/memos' do
  erb :index
end

get '/memos/new' do
  erb :edit
end

post '/memos' do
  create_new_memo incriment_max_id, escape(params[:title]), escape(params[:memo])
  redirect '/'
  erb :index
end

get '/memos/:id' do |id|
  @memo = select_memo id
  erb :show
end

get '/memos/:id/edit' do |id|
  @memo = select_memo id
  erb :edit
end

patch '/memos/:id' do |id|
  update_memo id, escape(params[:title]), escape(params[:memo])
  redirect '/'
  erb :index
end

delete '/memos/:id' do |id|
  delete_memo id
  redirect '/'
  erb :index
end

helpers do
  def escape(text)
    Rack::Utils.escape_html(text)
  end
end
