require 'json'
require 'rest_client'

class Product < Rhoconnect::Model::Base
  def initialize(source) 
    @base = 'http://rhostore.herokuapp.com/products'
    super(source)
  end
 
  def login
    # TODO: Login to your data source here if necessary
  end
 
  def query(params=nil)
    rest_result = RestClient.get("#{@base}.json").body

    if rest_result.code != 200
      raise Rhoconnect::Model::Exception.new("Error connecting!")
    end
    parsed = JSON.parse(rest_result)

    @result={}
    parsed.each do |item|
      @result[item["product"]["id"].to_s] = item["product"]
    end if parsed
  end

  def create(create_hash)
    res = RestClient.post(@base,:product => create_hash)

    # After create we are redirected to the new record.
    # We need to get the id of that record and return
    # it as part of create so rhoconnect can establish a link
    # from its temporary object on the client to this newly
    # created object on the server
    JSON.parse(
    RestClient.get("#{res.headers[:location]}.json").body
    )["product"]["id"]
  end
 
  def update(update_hash)
    obj_id = update_hash['id']
    update_hash.delete('id')
    RestClient.put("#{@base}/#{obj_id}",:product => update_hash)
    puts update_hash
  end
 
  def delete(delete_hash)
    RestClient.delete("#{@base}/#{delete_hash['id']}")
  end
 
  def logoff
    # TODO: Logout from the data source if necessary
  end

  def store_blob(object,field_name,blob)
    # TODO: Handle post requests for blobs here.
    # make sure you store the blob object somewhere permanently
    raise "Please provide some code to handle blobs if you are using them."
  end
end