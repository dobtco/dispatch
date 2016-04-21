xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Opportunities - #{DispatchConfiguration.site_title}"
    xml.description "Feed of opportunities posted to #{DispatchConfiguration.site_title}."
    xml.link opportunities_url

    for opportunity in @opportunities
      xml.item do
        xml.title opportunity.title
        xml.description opportunity.description
        xml.pubDate opportunity.updated_at.to_s(:rfc822)
        xml.link opportunity_url(opportunity)
        xml.guid opportunity_url(opportunity)
      end
    end
  end
end
