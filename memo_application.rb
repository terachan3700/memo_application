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
  @memos = DataFile.read_csv_data
  erb :index
end

get '/memos/new' do
  erb :edit
end

post '/memos' do
  DataFile.create_new_memo DataFile.increment_max_id, params[:title], params[:memo]
  redirect '/'
  erb :index
end

get '/memos/:id' do |id|
  @memo = DataFile.select_memo id
  erb :show
end

get '/memos/:id/edit' do |id|
  @memo = DataFile.select_memo id
  erb :edit
end

patch '/memos/:id' do |id|
  DataFile.update_memo id, params[:title], params[:memo]
  redirect '/'
  erb :index
end

delete '/memos/:id' do |id|
  DataFile.delete_memo id
  redirect '/'
  erb :index
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end
