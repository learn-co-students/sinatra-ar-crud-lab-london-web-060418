
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
	end

	get '/posts/new' do
		erb :new
	end

	get '/posts' do
		@posts = Post.all
		erb :index
	end

	post '/posts' do
		p params[:post]
		@post = Post.create(name: params[:name], content: params[:content])
		redirect '/posts'
	end

	get '/posts/:id' do
		# p params
		@post = Post.find(params[:id])
		erb :show
	end

	get '/posts/:id/edit' do
		@post = Post.find(params[:id])
		erb :edit
	end

	patch '/posts/:id' do
		@post = Post.find(params[:id])
		@post.update(name: params[:name], content: params[:content])
		@post.save
		redirect "/posts/#{@post.id}"
	end

	delete '/posts/:id/delete' do
		@post = Post.find(params[:id])
		@post.destroy
		redirect '/posts'
	end
end
