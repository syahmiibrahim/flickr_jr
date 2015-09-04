
get '/user/:id/album' do
  @user = User.find(params[:id])

  erb :index 
end

get '/albums/:id' do
  @album = Album.find(params[:id])
  @photo = Photo.where(album_id: params[:id])

  erb :'album/display'
end

get '/albums/new/:id' do 
  @user = User.find(params[:id])
  erb :'album/new'
end

post '/albums/new/:id' do
  @user = User.find(params[:id])

  input = params[:post]

  @new_album = @user.albums.build(input)

  if @new_album.save
    session[:id] = @user.id
    redirect "/albums/upload/#{@new_album.id}"
  else
    erb :'album/new'
  end
end

delete '/albums' do
  album = Album.find(params[:id])
  user = album.user 

  album.destroy 

  redirect "/user/#{user.id}"

end