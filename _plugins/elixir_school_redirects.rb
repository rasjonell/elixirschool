module ElixirSchoolRedirects

  REDIRECTS = {
    "" => "en",
    "cn" => "zh-hans",
    "jp" => "ja",
    "my" => "ma",
    "tw" => "zh-hant"
  }

  class RedirectPage < Jekyll::Page
    def initialize(site, category, page, from, to)
      @base = site.source
      @dir = File.join(from, category)
      @name = "#{page}.md"
      @site = site

      process(@name)

      self.content = ""
      self.data = {"redirect_to" => File.join(to, category, page)}
    end
  end

  class Generator < Jekyll::Generator
    def generate(site)
      REDIRECTS.each do |from, to|
        site.data["contents"].each do |category, pages|
          pages.each do |page|
            site.pages << RedirectPage.new(site, category, page, from, to)
          end
        end
      end
    end
  end
end
