#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "RJ Travels"
    xml.author "Ricardo Ortega"
    xml.description "Travels through South America"
    xml.link "http://rjtravels.world"
    xml.language "en"

    for article in @blogs
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author "Ricardo Ortega"
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link "http://rjtravels.world/blogs/" + article.name
        xml.guid article.name

        text = article.article
      end
    end
  end
end
