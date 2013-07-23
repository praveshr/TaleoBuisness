# # dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
# require File.join('/Users/pramachandran/.rvm/gems/ruby-1.9.3-p392/bin/', 'httparty')

require 'rubygems'
require 'httparty'
require 'json'

class People 
  include HTTParty
  base_uri "https://api.icims.com"
  format :json
  # cred = "SelectJobPosting:welcome1"
 
  # cred = "integaccou86654:matrix12"
  # auth = "Basic "+ Base64.encode64(cred)
  headers = {"Content-Type" => "application/json" ,"encoding" =>"UTF-8"}
  
  
  # options = {:headers => headers, :ssl_version => 'SSLv3', :body => {
  #                   # "folder" => {"id" => "D32002","value" => "Purge"},
  #                   "source" => "CareerBuilder (Mobile Apply)",
  #                   "folder" => {"id" => "D32007","value" => "Cand:Active"},
  #                   "email" => "test1@domain.com",
  #                   "lastname" => "testfirst",
  #                   "firstname" => "testlast"
  #                   # "resume" => ""
  #                   }.to_json}
        
    
    # To Find your instance (Get host url)              
    # res = HTTParty.get('https://tbe.taleo.net/MANAGER/dispatcher/api/v1/serviceUrl/SHERWIN', :headers => headers, :ssl_version => 'SSLv3')
    
    # To Login - Get auth token
    res = HTTParty.post('https://ch.tbe.taleo.net/CH04/ats/api/v1/login?orgCode=SHERWIN&userName=wkrupa&password=sherwin-Pass@word123', :headers => headers, :ssl_version => 'SSLv3')
    grab_cookie = res.headers['Set-Cookie'].split('; ')[0]
   
    puts grab_cookie
    puts res["authToken"].inspect
    
    # Discovery of services 
    
    # res = HTTParty.post('https://ch.tbe.taleo.net/CH04/ats/api/v1/object/info', headers => headers, :ssl_version => 'SSLv3')
    
    
    
  
     
  
  puts res.inspect
end

