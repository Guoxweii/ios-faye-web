class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  
protected
  def publish(channel, data)
    address = "http://127.0.0.1:9292/faye"
    content = {
      :body => { 
        :message => {
          :channel => channel,
          :data => data
        }.to_json
      }
    }
    
    HTTParty.post(address, content)
  end
end
