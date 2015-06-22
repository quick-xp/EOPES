class CrestDebugsController < ApplicationController
  before_filter :authenticate_user!

  # GET /crest_debugs
  # GET /crest_debugs.json
  def index
    @init_url = "https://crest-tq.eveonline.com/market/" +
        "10000002" +
        "/orders/"+ "sell" + "/?type=https://crest-tq.eveonline.com/types/" +
        "34" +
        "/"
  end

  def get_crest
    url = params[:crest_url]
    result = get_token.get(url)
    #@url_result = result.to_json
    @url_result = ActiveSupport::JSON.decode(result.response.env.body)
    @url_result = ActiveSupport::JSON.encode(@url_result)
  end
end
