require 'rubygems'
require 'httparty'
require 'json'
require 'addressable/uri'
require 'base64'
require 'date'
require 'mechanize'
require 'cgi'
require 'uri'
require 'hashie'
require 'rest_client'


    
  
  
  

   # step=> 1  ***********************************
       # Finding your instance
      # http_response = HTTParty.get("https=>//tbe.taleo.net/MANAGER/dispatcher/api/v1/serviceUrl/"+"#{taleo_cmp_id}")
      #          json_hash = JSON.parse(http_response.response.body)
      #          api_response = Hashie=>=>Mash.new(json_hash)
      #          host_url = api_response.response.URL.to_s
      #      puts host_url
      host_url = "https=>//ch.tbe.taleo.net/CH04/ats/api/v1/"
     
    #self.base_uri "#{host_url}"
   
  #  step=> 2 ************************************
    # query_params = {
    #                              =>orgCode => 'SHERWIN',
    #                              =>userName => 'wkrupa',
    #                              =>password => "sherwin-Pass@word123"
    #                          }
    #                          login_resp = HTTParty.post("#{host_url}"+"login", =>query => query_params)
    #                          login_hash = JSON.parse(login_resp.response.body)
    #                          resp =   Hashie=>=>Mash.new(login_hash)
    #                          puts resp
               
    # auth token I got from response  (valid till 4 hours) need to concentrate more on auth_token expire or invalid

    set_cookie = "webapi23086547645613303871"   # here after no need of credentials once we get auth_token
    #logout_resp = HTTParty.post("#{host_url}"+"logout", =>query => query_params)
   
       # resp_services = HTTParty.post("#{host_url}"+"object/info",=>headers => headers , =>cookies => {=>authToken => set_cookie})
       #        puts resp_services.inspect
   
   # Check for services 
       # service_resp = HTTParty.get("#{host_url}"+"object/info",=>headers => headers ,  =>cookies => {=>authToken => set_cookie})
       #        puts service_resp.inspect
   
   
 # step => 3   ********************************************   

  # sample candidate profile
       example =  {"candidate"=> {
       "city"=> "San Francisco",
       "country"=> "US",
       "resumeText"=> "test test test",
       "email"=> "tqatest9@invalidemail.com",
       "firstName"=> "Test9",
       "lastName"=> "QAtest9",
       "status"=> 2,
       "middleInitial"=> "F",
       "cellPhone"=> "415-256-5219",
       "race"=> "White (not Hispanic or Latino)",
       # "source"=> "Careers Website",
       "state"=> "US-CA",
       "address"=> "653 New Ave",
       "veteran"=> [
       "None"
       ],
       "zipCode"=> "94122"
       }
       }.to_json
               
           
               headers = {"Content-Type" => "application/json" ,"encoding" =>"UTF-8" }
     #     
     #     
     #     
     # candidate_resp = HTTParty.post("https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate", :headers => headers , :body => example, :cookies => {:authToken => set_cookie})
     
     candidate_resp = HTTParty.get("https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184293/resume", :headers => headers , :cookies => {:authToken => set_cookie})
     # candidate_resp = HTTParty.post("https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184293/resume", :headers => headers , :cookies => {:authToken => set_cookie})
     #     
      puts candidate_resp.inspect



     # Passing Resume. 
     # rest = RestClient.post('', 
     #     :file => File.new('/Users/pramachandran/CBWorkspace/Projects/MobileApply/Pravesh-Resume.docx'), :multipart => true,  :headers => headers , :cookies => {:authToken => set_cookie})
     #     
     #    puts  rest.inspect
    
    # request = RestClient::Request.new(
    #               :method => :post,
    #               :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184293/attachment',
    #               :cookies => {:authToken => set_cookie},
    #               :payload => {
    #                 :multipart => true,
    #                 :file => File.new("/Users/pramachandran/CBWorkspace/Projects/MobileApply/Pravesh-Resume.docx", 'rb')
    #               })      
    #     response = request.execute
    #     puts response.inspect

      
      #  puts s
      #       



