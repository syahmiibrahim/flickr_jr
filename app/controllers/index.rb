get '/' do
  # Look in app/views/index.erb
  @photos = Photo.all.order('id DESC')
  erb :index
end
