get '/albums/upload/:id' do 
  @new_album = Album.find(params[:id])
  @user = User.find(session[:id])

  erb :'/photo/new'
end

get '/albums/:album_id/:photo_id' do 
  @photo = Photo.find(params[:photo_id])
  @album = Album.find(params[:album_id])
  byebug
  erb :'/photo/display'
end

post '/photo' do 

  input = params[:post]

  @photo = Photo.new(album_id: input[:album_id], file_name: input[:file_name][:filename], caption: input[:caption])
  @photo.save

  File.open('public/images/'+ input[:file_name][:filename],"w") do |f|
    f.write(input[:file_name][:tempfile].read)
  end

  redirect "/albums/#{@photo.album_id}/#{@photo.id}"
end

post '/albums/:album_id' do
  @current_album = Album.find(params[:album_id])
  @user = User.find(session[:id])

  redirect "/albums/upload/#{@current_album.id}"
end

delete '/photo/:id' do
  Photo.find(params[:id]).destroy

  redirect '/photo'
end