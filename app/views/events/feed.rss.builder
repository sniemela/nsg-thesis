xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title I18n.t('title.latest_events')
    xml.description I18n.t('title.latest_events')
    xml.link root_path

    for event in @events
      xml.item do
        xml.title event.name
        xml.description event.description
        xml.pubDate event.created_at.to_s(:rfc822)
        xml.link event_path(event)
        xml.guid event_path(event)
        xml.comments event_path(event, :anchor => 'event-comments')
        xml.author event.submitter.name

        for category in event.categories
          xml.category(category.name, "domain" => category_path(category))
        end
      end
    end
  end
end
