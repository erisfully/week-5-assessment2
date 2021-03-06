require "sinatra"
require "./lib/database"
require "./lib/contact_database"
require "./lib/user_database"

class ContactsApp < Sinatra::Base
  enable :sessions

  def initialize
    super
    @contact_database = ContactDatabase.new
    @user_database = UserDatabase.new

    jeff = @user_database.insert(username: "Jeff", password: "jeff123")
    hunter = @user_database.insert(username: "Hunter", password: "puglyfe")

    @contact_database.insert(:name => "Spencer", :email => "spen@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Jeff D.", :email => "jd@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Mike", :email => "mike@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Kirsten", :email => "kirsten@example.com", user_id: hunter[:id])
  end

  get "/" do
      erb :root
  end

  post "/login" do
    @user_database.insert({username: params[:username], password: params[:password]})
    if @user_database != nil
      contact_list = @contact_database.all.select{|contact| contact[:user_id]  == params[:username][:id]}
      erb :userhome, :locals => {:contacts => contact_list}
    else
      erb :root
    end
  end

  get "/login" do
    erb :login
  end
end

