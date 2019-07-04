class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Ice Cream", "Bananas", "Eggs"]
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  
  
  
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if !@@cart.empty?
      @@cart.each do |item|
        resp.write "#{item}\n"
      end

    elsif @@cart.empty?
      resp.write "Your cart is empty"
    end

    resp.finish
  end




  def add
    
    search_item = req.params["item"]
    if @@items.include? (search_item)
      @@cart << search_item
    else
      resp.write "We don't have that item"

    end
end
  
end


=begin

 describe "/add" do

    it 'Will add an item that is in the @@items list' do
      Application.class_variable_set(:@@items, ["Figs","Oranges"])
      get '/add?item=Figs'
      expect(last_response.body).to include("added Figs")
      expect(Application.class_variable_get(:@@cart)).to include("Figs")
    end

    it 'Will not add an item that is not in the @@items list' do
      Application.class_variable_set(:@@items, ["Figs","Oranges"])
      get '/add?item=Apples'
      expect(last_response.body).to include("We don't have that item")
    end
  end
  
=end
