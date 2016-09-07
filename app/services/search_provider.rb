class SearchProvider
  def initialize
    @agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
  end

  def search_aw(zipcode)
    available_aw = false
    @agent.get('https://www.affinitywater.co.uk/our-supply-area-moving-home.aspx') do |page|
      page.form_with(:id => 'form1') do |search|
        field = search.text_field? 'template$txtPostcodePanelSearch'
        field.value = zipcode
        submit_btn = search.submit_button? 'template$btnPostcodePanelSearch'
        response =  @agent.click submit_btn
        available_aw = response.css('h3').text == 'Affinity Water supplies your area.'
      end.submit
    end
    available_aw
  end

  def search_thw(zipcode)
    available_tw = false
    @agent.get('http://www.thameswater.co.uk/your-account/605.htm') do |page|
      page.form_with(:id => 'watersupplyform') do |search|
        field = search.text_field? 'postcode1'
        field.value = zipcode
        response = search.submit
        available_tw = response.css('h1').text == 'Your property is in our supply area'
      end.submit
    end
    available_tw
  end

  def match(zipcode)
    /(GIR 0AA)|((([A-Z-[QVX]][0-9][0-9]?)|(([A-Z-[QVX]][A-Z-[IJZ]][0-9][0-9]?)|(([A-Z-[QVX]][0-9][A-HJKPSTUW])|([A-Z-[QVX]][A-Z-[IJZ]][0-9][ABEHMNPRVWXY])))) [0-9][A-Z-[CIKMOV]]{2})/.match zipcode
  end
end