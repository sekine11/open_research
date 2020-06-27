namespace :news_acquisition do
  desc "ニュースを定期的に取得"
  task recover: :environment do
    logger = Logger.new 'log/news_acquisition.log'

    NewsList.transaction do
      NewsList.destroy_all
      news = News.new(ENV['NEWS_KEY'])
      headlines = news.get_top_headlines(country: 'jp', language: 'jp', category: "science")
      headlines.each do |news|
        NewsList.create(title: news.title, url: news.url, published_at: news.publishedAt)
      end
      rescue => e
        logger.error e
    end
  end
end