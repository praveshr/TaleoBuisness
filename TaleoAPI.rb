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


class TaleoAPI
  
  include HTTParty
  format :json

# View your taleo instance to get host url and server this instance is running on

  def view_instance
    
    @company_code = "SHERWIN"
    res = HTTParty.get("https://tbe.taleo.net/MANAGER/dispatcher/api/v1/serviceUrl/#{@company_code}")
    json_hash = JSON.parse(res.response.body)
    api_res = Hashie::Mash.new(json_hash)
    host_url = api_res.response.URL.to_s
    puts host_url
    
  end
  
  
  # Login to get authorization token
  
  def login
    
    query_params = {
                      :orgCode => 'SHERWIN',
                      :userName => 'wkrupa',
                      :password => "sherwin-Pass@word123"
                    }
                    
    login_resp = HTTParty.post("#{@host_url}/login", :query => query_params)
    login_hash = JSON.parse(login_resp.response.body)
    resp =   Hashie::Mash.new(login_hash)
    
    # View authtoken                 
    puts resp
  
  end
  
  
  def check_services 
    
    # Paste value of cookie here once you execute login 
    
    @set_cookie = "webapi2-2513569143322432626"
    
    service_resp = HTTParty.get("#{@host_url}/object/info", :headers => {"Content-Type" => "application/json" ,"encoding" =>"UTF-8"} ,
      :cookies => {:authToken => @set_cookie})
    
    # View Services 
    
    puts service_resp.inspect
    
    # You can view these services by parsing output properly further
    
  end
  
  
  
  def initialize (headers = {"Content-Type" => "application/json" ,"encoding" =>"UTF-8"}, host_url = "https://ch.tbe.taleo.net/CH04/ats/api/v1", 
    set_cookie = "webapi2935733858459782247")

     @headers = headers
     @host_url = host_url
     @set_cookie = set_cookie

   end
  
  
  def candidateAdministration
    
    options = {:headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie}, :body => {
                          "candidate"=> {
                          "city"=> "San Francisco",
                          "country"=> "US",
                          "resumeText"=> "test test test",
                          "email"=> "praveshtest@gmailtest.com",
                          "firstName"=> "Pravesh test demo",
                          "lastName"=> "Ramachandran test demo",
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
                          
    }
    
    # Sample candidate id's creating. Please use this. don't create more.
     # 184293 {firstName"=>"Test9", "lastName"=>"QAtest9",  "email"=>"tqatest9@invalidemail.com"}
     # 184343 {"firstName"=>"Pravesh.test", "email"=>"test@nobody.com", "lastName"=>"Ramachandran.test"}
   
    
    
    create_url = "#{@host_url}/object/candidate"
    create_uri = Addressable::URI.parse(create_url)
    
    
    update_url = "#{@host_url}/object/candidate/184343"
    update_uri = Addressable::URI.parse(update_url)
   
      
    view_url = "#{@host_url}/object/candidate/184343"
    view_uri = Addressable::URI.parse(view_url)
    
    delete_url = "#{@host_url}/object/candidate/184343"
    delete_uri = Addressable::URI.parse(view_url)
    
    # Create a new* candidate
      # res = HTTParty.post(create_uri.to_s,options)
    
    # Update an Existing Candidate
      # res = HTTParty.put(update_uri.to_s,options)
      
    # View an Existing Candidate 
      res = HTTParty.get(view_uri.to_s, :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie})
      
    # Delete an Existing Candidate 
      # res = HTTParty.delete(delete_uri.to_s, :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie})
      
      
      puts res.inspect
     
    
    
  end
  
  
  def view_relationshipUrls
    
    # View all relationship urls for a candidate
    
     view_url = "#{@host_url}/object/candidate/184343"
     view_uri = Addressable::URI.parse(view_url)
     
     res = HTTParty.get(view_uri.to_s, :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie})
     
     # puts res["response"]["candidate"]["relationshipUrls"].inspect
     puts res.inspect
     
     
   # View candidate status url
   
      # puts res["response"]["candidate"]["relationshipUrls"]["status"].inspect
   
   
   # View candidate requisition url

      # puts res["response"]["candidate"]["relationshipUrls"]["requisition"].inspect
    
   # View candidate attachments url

      # puts res["response"]["candidate"]["relationshipUrls"]["attachments"].inspect
    
   # View candidate workhistory url

      # puts res["response"]["candidate"]["relationshipUrls"]["workhistory"].inspect
      
   # View candidate education url

      # puts res["response"]["candidate"]["relationshipUrls"]["education"].inspect
    
    
   
  end
  
  
  def attachment
    
   
    
    upload_request = RestClient::Request.new(
                      :method => :post,
                      :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184343/attachment',
                      :cookies => {:authToken => @set_cookie},
                      :payload => {
                        :multipart => true,
                        :file => File.new("/Users/pramachandran/CBWorkspace/Projects/MobileApply/ChaudharyShashank_Resume.pdf", 'rb')
                      })
                      
                            
      # Upload/Update any attachment. ( Here attachment refers to resume)   

         res = upload_request.execute
                        puts res.inspect
                      
    
     update_request = RestClient::Request.new(
                             :method => :post,
                             :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184343/attachment/83466',
                             :cookies => {:authToken => @set_cookie},
                             :payload => {
                               :multipart => true,
                               :file => File.new("/Users/pramachandran/CBWorkspace/Projects/MobileApply/Pravesh-Resume.docx", 'rb')
                             })

        # Upload/Update any attachment. ( Here attachment refers to resume)   

          # res = update_request.execute
          #           puts res.inspect
          
          
    
    delete_request = RestClient::Request.new(
                      :method => :delete,
                      :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184343/attachment/83466',
                      :cookies => {:authToken => @set_cookie},
                      :payload => {
                        :multipart => true
                      })   
                      
    # Delete any attachment. ( Here attachment refers to resume)   
    
        # res = delete_request.execute
        #              puts res.inspect
    
     view_request = RestClient::Request.new(
                      :method => :delete,
                      :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184343/attachment/83466',
                      :cookies => {:authToken => @set_cookie},
                      :payload => {
                      :multipart => true
                      })
        
      
                      
    # Download/View resume attachment submission
    
        # res = view_request.execute
        # puts res.inspect
  
  end
  
 
  def resume_attachment



     upload_request = RestClient::Request.new(
                       :method => :post,
                       :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184343/resume',
                       :cookies => {:authToken => @set_cookie},
                       :payload => {
                         :multipart => true,
                         :file => File.new("/Users/pramachandran/CBWorkspace/Projects/MobileApply/ChaudharyShashank_Resume.pdf", 'rb')
                       })


       # Upload/Update any attachment. ( Here attachment refers to resume)   

          # res = upload_request.execute
          # puts res.inspect


      update_request = RestClient::Request.new(
                              :method => :post,
                              :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184343/resume/id',
                              :cookies => {:authToken => @set_cookie},
                              :payload => {
                                :multipart => true,
                                :file => File.new("/Users/pramachandran/CBWorkspace/Projects/MobileApply/Pravesh-Resume.docx", 'rb')
                              })

         # Upload/Update any attachment. ( Here attachment refers to resume)   

           # res = update_request.execute
           #           puts res.inspect



     delete_request = RestClient::Request.new(
                       :method => :delete,
                       :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184343/attachment/83466',
                       :cookies => {:authToken => @set_cookie},
                       :payload => {
                         :multipart => true
                       })   

     # Delete any attachment. ( Here attachment refers to resume)   

         # res = delete_request.execute
         #              puts res.inspect

      view_request = RestClient::Request.new(
                       :method => :delete,
                       :url => 'https://ch.tbe.taleo.net/CH04/ats/api/v1/object/candidate/184343/attachment/83466',
                       :cookies => {:authToken => @set_cookie},
                       :payload => {
                       :multipart => true
                       })



     # Download/View resume attachment submission

         # res = view_request.execute
         # puts res.inspect

   end
  
  
  def requisition
       # 
       # This is to create a job! Don't attempt this yet. We'l have a sample job created soon
       view_url = "#{@host_url}/object/requisition/3797/question"
       view_uri = Addressable::URI.parse(view_url)
       
       # 3710 - Has questions
       # 3105

        res = HTTParty.get(view_uri.to_s, :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie})
        
        # puts res["response"]["candidate"]["relationshipUrls"].inspect
        # Istemplate true output only
        puts res.inspect
        # puts res["response"]["requisition"]["isTemplate"]
        
       
       
     end 
  
     def questions_library

          # This is to create a job! Don't attempt this yet. We'l have a sample job created soon
          
          # view_url = "#{@host_url}/object/info/question" # Retrives meta data
          #           view_url = "#{@host_url}/object/question/description/standard" # Retrieves standard fields -hardcoded
          #           view_url = "#{@host_url}/object/displayfield/QUEST/{fieldname}" # Retrieves display field info –hardcoded
          #           view_url = "#{@host_url}/object/question(?category={category})" # Retrieves questions by category; returns all questions if no category is  passed
          #           view_url = "#{@host_url}/object/question/{id}" # Retrieves question by 
          
          
          view_url1 = "#{@host_url}/object/requisition/3687/question" # Retrieves all questions related to requisition
          view_url2 = "#{@host_url}/object/question/9/answer/" # Retrieves all questions related to requisition
          view_url3 = "#{@host_url}/object/question/answer/description/custom"
           view_uri = Addressable::URI.parse(view_url3)

           res = HTTParty.get(view_uri.to_s, :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie})
           puts res.inspect
           # puts res.inspect
           # Display all questions 
                      # data = res["response"]["question"]
                      #                                                        
                      #                                                        data.each do |item|
                      #                                                          puts "Question: " + item["question"]["question"].to_s 
                      #                                                          puts "Required field: " + item["question"]["mandatory"].to_s
                      #                                                          puts "Answer Url: " + item["question"]["relationshipUrls"]["answers"].to_s 
                      #                                                          # puts HTTParty.get(Addressable::URI.parse(item["question"]["relationshipUrls"]["answers"]), :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie})
                      #                                                          # puts HTTParty.put(Addressable::URI.parse(item["question"]["relationshipUrls"]["answers"] + "0"), :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie}) 
                      #                                                          puts "\n" + "\n"
                      #                                                          # post_url = HTTParty.post(Addressable::URI.parse(item["question"]["relationshipUrls"]["answers"]))
                      #                                                          
                      #                                                          
                      #                                                        end

        end
  
  def candidateApplication
    
   #  NOTE: Not tested yet, since we don't have a sample job requisition from sherwin williams
   # Sample canidate application : 201641
     options = {:headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie}, :body => {
       "candidateapplication" => {
         "candidateId" => 189408,
         "requisitionId" => 3797,
         # "preRejectionStatus" =>  1,
         "status" => 14, # parsed_response={"response"=>{}, "status"=>{"detail"=>{"operation"=>"internal", "errormessage"=>"Status with id cannot be found", "error"=>"Status with id cannot be found", "errorcode"=>"500"}, "success"=>false}},
         "reasonRejected"=> "1"
         #         "rank" => 100,
         #         "dateApplied" => "2012-04-30"
       }}.to_json
     }

#[{"entityType"=>"CAREQ", "id"=>1, "text"=>"-"},
# {"entityType"=>"CAREQ", "id"=>2, "text"=>"Added to Requisition"},
# {"entityType"=>"CAREQ", "id"=>5, "text"=>"Recruiter Screening"}, 
#{"entityType"=>"CAREQ", "id"=>6, "text"=>"Send to Mgr"},
# {"entityType"=>"CAREQ", "id"=>8, "text"=>"Manager Interviewing"},
# {"entityType"=>"CAREQ", "id"=>10, "text"=>"Store Visit"},
# {"entityType"=>"CAREQ", "id"=>11, "text"=>"Offer"}, 
#{"entityType"=>"CAREQ", "id"=>13, "text"=>"Offer Declined"}, 
#{"entityType"=>"CAREQ", "id"=>14, "text"=>"Disqualified"}, 
#{"entityType"=>"CAREQ", "id"=>16, "text"=>"Hired"},
# {"entityType"=>"CAREQ", "id"=>17, "text"=>"Not Minimally Qualified"}, 
#{"entityType"=>"CAREQ", "id"=>5001, "text"=>"Resume Reviewed"},
# {"entityType"=>"CAREQ", "id"=>5002, "text"=>"Missing Resume"}, 
#{"entityType"=>"CAREQ", "id"=>5003, "text"=>"Store Visit Disqualified"}, 
#{"entityType"=>"CAREQ", "id"=>5004, "text"=>"Withdrew at Store Visit"}, 
#{"entityType"=>"CAREQ", "id"=>5005, "text"=>"Recruiter Interviewing"}, 
#{"entityType"=>"CAREQ", "id"=>5006, "text"=>"District Manager Disqualified"}]}, 

      create_url = "#{@host_url}/object/candidateapplication"
      create_uri = Addressable::URI.parse(create_url)


      update_url = "#{@host_url}/object/candidateapplication/202020"
      update_uri = Addressable::URI.parse(update_url)

      # "#{@host_url}/object/status/CAREQ/"
      # view_url = "#{@host_url}/object/candidateapplication/preRejectionStatus"
      # view_url = "#{@host_url}/object/displayfield/CAREQ/reasonRejected"
      view_url = "#{@host_url}/object/status/CAREQ/"
      # view_url = "#{@host_url}/object/candidateapplication/189408/candidate"
      view_uri = Addressable::URI.parse(view_url)

      delete_url = "#{@host_url}/object/candidateapplication/202020"
      delete_uri = Addressable::URI.parse(delete_url)

      # Create a new* candidateApplication
        # res = HTTParty.post(create_uri.to_s,options)

      # Update an Existing candidateApplication
        res = HTTParty.put(update_uri.to_s,options)
        
      # View an Existing candidateApplication 
        # res = HTTParty.get(view_uri.to_s, :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie})

      # Delete an Existing candidateApplication 
        # res = HTTParty.delete(delete_uri.to_s, :headers => @headers, :ssl_version => 'SSLv3', :cookies => {:authToken => @set_cookie})


        puts res.inspect
 end
      

  
  
  
  
end
  
  # Create an object for this call and execute methods

  j = TaleoAPI.new

  # j.view_instance
  j.login
  # j.check_services
  # j.candidateAdministration
  # j.view_relationshipUrls
  # j.resume_attachment
  # j.attachment
  # j.candidateApplication 
   # j.requisition
  # j.questions_library
  
  
  # parsed_response={"response"=>{}, "status"=>{"detail"=>{"operation"=>"internal", "errormessage"=>"Login session for token webapi23773621252978078235 is expired or invalid.", "error"=>"Login session for token webapi23773621252978078235 is expired or invalid.", "errorcode"=>"500"}, "success"=>false}}, @response=#<Net::HTTPInternalServerError 500 Internal Server Error readbody=true>, @headers={"date"=>["Tue, 21 May 2013 16:13:00 GMT"], "server"=>["Apache"], "set-cookie"=>["JSESSIONID=6F10F9691BBF2132D83BD9AAC9B6BC8A.NA10_primary_jvm; Path=/CH04/ats/; Secure"], "pragma"=>["no-cache"], "cache-control"=>["no-cache, no-store, max-age=0"], "expires"=>["Thu, 01 Jan 1970 00:00:00 GMT"], "content-language"=>["en-US"], "vary"=>["Accept-Encoding,User-Agent"], "connection"=>["close"], "transfer-encoding"=>["chunked"], "content-type"=>["application/json;charset=UTF-8"]}>
  

  
  
  
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
