#!/usr/bin/env ruby

require 'rubygems'
require 'scrapi'
require 'open-uri'
require 'rio'

post_it_title_and_image = Scraper.define do
  process "h3.post-title > a", :title => :text
  process "div.post-body > a:first-child > img", :image => "@src"
  result :image, :title
end

older_posts_link = Scraper.define do
end

twf = Scraper.define do
  array :titles_and_images
  
  process "div.post", :titles_and_images => post_it_title_and_image
  process "span#blog-pager-older-link > a", :older_posts_link => "@href"
  
  result :titles_and_images, :older_posts_link
end

url = "http://thingsweforget.blogspot.com/"
begin
  result = twf.scrape(open(url).read)
  result.titles_and_images.each do |title_and_image|
    if title_and_image.title =~ /^#(\d+)/
      puts "Post #{title_and_image.title}"
      puts "Imagen: #{$1}"
      filename = "images/#{$1}.jpg"
      rio(title_and_image.image) > rio(filename)
    end
  end
  puts "next url: #{result.older_posts_link}"
  url = result.older_posts_link
end while url;
