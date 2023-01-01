require 'rails_helper'

RSpec.describe "Task11s", type: :request do
  describe "GET /task11/input" do
    it "returns http success" do
      get "/task11/input"
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /task11/output" do
    it "returns http success" do
      get "/task11/output"
      expect(response).to have_http_status(:success)
    end

    it "returns correct result" do
      get "/task11/output.x?digit=3&commit=Enter"
      html_doc = Nokogiri::HTML(response.body)
          expect([153, 370, 371, 407]).to eq(html_doc.css('table').css('tr')[1..].map do |row|
                                                        row.css('td')[1].text.to_f
                                                      end)
    end
  end
end
