get '/users/new' do
  @user = User.new
  erb :"users/new"
end

post '/users' do
  @user = User.create(:email => params[:email],
                      :password => params[:password],
                      :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :"users/new"
  end

end

get '/users/reset_password/:token' do
  puts request.url
  @user = User.first(:password_token => params[:token])
  if hour_time_limit? @user.password_token_timestamp.to_time
    erb :"users/reset_password/:token"
  else
    flash[:notice] = "Your token has expired. Please request another password"
    redirect to('sessions/recover')
  end
end

post '/users/reset_password' do
  @user = User.first(:password_token => params[:password_token])
  @user.password = params[:password]
  @user.password_confirmation = params[:password_confirmation]
  @user.password_token = nil
  @user.password_token_timestamp = nil
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :"/users/reset_password/:token"
  end

end
