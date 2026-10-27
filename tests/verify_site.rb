# Run after `bundle exec jekyll build`. Checks the rendered site, not templates.
require 'yaml'
require 'nokogiri'
require 'uri'

root = File.expand_path('..', __dir__)
output = ARGV[0] || File.join(root, '_site')
baseurl = ARGV[1] || ''
page = Nokogiri::HTML(File.read(File.join(output, 'index.html')))

def check(condition, message)
  abort "FAIL: #{message}" unless condition
end

sections = %w[about research-interests news publications patents teaching professional-services invited-talks awards]
sections.each do |id|
  check(page.css("##{id}").length == 1, "unique section anchor: #{id}")
  check(page.at_css("nav a[href='##{id}']"), "menu link: #{id}")
end
check(page.css('h1').length == 1, 'one primary heading')
news = YAML.load_file(File.join(root, '_data/news.yml'))
latest = page.css('#news .news-latest > li')
archive = page.css('#news details .news-archive > li')
check(latest.length == [10, news.length].min, '10 latest news items')
check(latest.length + archive.length == news.length, 'complete news archive')
check(!page.at_css('#news details').key?('open'), 'older news collapsed by default')
(latest + archive).zip(news).each do |element, entry|
  text = element.text.gsub(/\s+/, ' ').strip
  expected = "[#{entry['date']}] #{entry['text']}"
  check(text == expected, "news text/order: #{entry['date']}")
end
papers = YAML.load_file(File.join(root, '_data/publications.yml'))['main']
rendered = page.css('#publications .publication-list > li')
check(rendered.length == papers.length, 'all publications rendered')
papers.zip(rendered).each do |paper, element|
  %w[title authors conference notes].each do |field|
    next unless paper[field]
    expected = Nokogiri::HTML.fragment(paper[field]).text.gsub(/\s+/, ' ').strip
    check(element.text.gsub(/\s+/, ' ').include?(expected), "publication #{field}: #{paper['title']}")
  end
  %w[pdf code page bibtex].each do |field|
    next unless paper[field]
    check(element.css('a').any? { |a| a['href'] == paper[field] }, "publication link #{field}")
  end
end
check(page.css('#publications img').empty?, 'no publication thumbnails')
check(page.css('a[href=""]').empty?, 'no empty links for accepted papers')
# These sections stay in their original includes; check every original list item.
%w[patents teaching services talks awards].each do |name|
  original = Nokogiri::HTML.fragment(File.read(File.join(root, "_includes/#{name}.md")))
  original.css('li').each do |item|
    expected = item.text.gsub(/\s+/, ' ').strip
    check(page.text.gsub(/\s+/, ' ').include?(expected), "preserved #{name} entry")
  end
end
local_assets = page.css('link[rel="stylesheet"], link[rel="icon"], script[src], img[src]')
local_assets.each do |asset|
  path = asset['src'] || asset['href']
  next if path =~ %r{\Ahttps?://}
  check(path.start_with?("#{baseurl}/assets/"), "baseurl asset: #{path}")
  relative = path.delete_prefix(baseurl).delete_prefix('/')
  check(File.file?(File.join(output, relative)), "asset exists: #{relative}")
end
check(page.at_css('link[rel="canonical"]')['href'] == 'https://lemonviv.github.io/', 'correct canonical URL')
puts "PASS: #{sections.length} sections, #{news.length} news (#{latest.length} latest), #{papers.length} publications, preserved section entries and local assets (baseurl=#{baseurl.inspect})"
