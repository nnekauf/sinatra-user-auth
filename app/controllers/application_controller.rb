class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  

  get '/' do
    erb :home
  end

  

  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

  post '/registrations/signup' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save 
    session[:user_id] = @user.id
    
     redirect '/users/home'
  end

  get '/users/home' do

      @user = User.find_by(id: session[:user_id])
    erb :'/users/home'
  end
 

  get '/sessions/login' do

  #   # the line of code below render the view page in app/views/sessions/login.erb
     erb :'sessions/login'
  end

  post '/sessions/login' do
    @user = User.find_by(email: params["email"], password: params["password"])
    # binding.pry
    session[:user_id] = @user.id 
  #   # @user = User.find_by(email: params[:email], password: params[:password])
  #   # # session[:user_id] = @user.id 
  #   # if @user
  #   #   session[:user_id] = @user.id
        redirect '/users/home'
  #   # else
  #   #   redirect '/sessions/login'
  #   # end
  #   # 
  end

  get '/sessions/logout' do
    session.clear
     redirect '/'
  end

  
end
