get '/sessions/new' do

  erb :"sessions/new"
end

post '/sessions' do
  email, password = params[:email], params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The email or password is incorrect"]
    erb :"sessions/new"
  end
end

delete '/sessions' do
  flash[:notice] = "Good bye!"
  session[:user_id] = nil
  redirect to('/')
end

get '/sessions/recover' do
  erb :"/sessions/recover"
end

post '/sessions/recover' do
  email = params[:email]
  user = User.first(email: email)
  if user
    user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
    user.password_token_timestamp = Time.now
    user.save
    user.send_password_reset
    erb :"/sessions/request_password"
  else
    flash[:notice] = ["You cannot reset a password for an unregistered user. Please register first."]
    redirect to('/sessions/new')
  end
end

post '/sessions/request_password' do
  erb :"/sessions/request_password"
end
