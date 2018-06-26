
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do   #loads new form
    erb :new
  end

  post '/posts' do     #creates a new blog post in "/posts"
    @post = Post.create(params)
    redirect to '/posts'
  end

  get '/posts' do       #loads all the blog entries
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do       #loads show page for the selected id
    @post = Post.find_by_id(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do   #allows to edit the selected id
    @post = Post.find_by_id(params[:id])
    erb :edit
  end

  patch '/posts/:id' do    #updates the post
    @post = Post.find_by_id(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    erb :show
  end

  delete '/posts/:id/delete' do  #deletes the selected post
    @post = Post.find_by_id(params[:id])
    @post.delete
    erb :deleted
  end

end
