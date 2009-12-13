#!/usr/bin/env ruby

require 'rubygems'
require 'scrapi'
require 'open-uri'

post_it_image = Scraper.define do
  process "div.post-body > a:first-child > img", :image => "@src"
  result :image
end

older_posts_link = Scraper.define do
end

twf = Scraper.define do
  array :images
  
  process "div.post-body", :images => post_it_image
  process "span#blog-pager-older-link > a", :older_posts_link => "@href"
  
  result :images, :older_posts_link
end

url = "http://thingsweforget.blogspot.com/"

fd = File.open("results.txt", "w")

result = twf.scrape(open(url).read)
i = 327
while result.older_posts_link
  result.images.each do |image|
    fd.write("#{i} - #{image}\n")
    i-=1
  end
  puts "#{result.images.size} images"
  puts "next url: #{result.older_posts_link}"
  result = twf.scrape(open(result.older_posts_link).read)
end

fd.close