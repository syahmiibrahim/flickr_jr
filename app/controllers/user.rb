get '/login' do 

  erb :login

end

post '/login' do
  input = params[:post]

  @user = User.authenticate(input[:username],input[:password])

    if @user
      session[:id] = @user.id
      redirect "/"
    else
      erb :login
    end

end

post '/signup' do
  input = params[:post]

  @user = User.create(username: input[:username], password: input[:password])

  if @user.save
    session[:id] = @user.id
    redirect "/"
  else
    erb :login
  end
end

delete '/logout' do
  session.clear
  redirect '/'
end

get'/user/:id' do
  @user = User.find(params[:id])

  @all_album = Album.where(user_id: @user.id).order('id DESC')

  erb :'album/index'
end

get '/user/album/:user_id' do
  @user = User.find(params[:user_id])

  erb :index
end