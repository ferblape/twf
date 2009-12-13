#!/usr/bin/env ruby

require 'rubygems'
require 'rio'

fd = File.open("results.txt")
lines = fd.readlines
fd.close
i = 0
while i < lines.size
  number, url = lines[i].split(' - ')
  filename = "images/#{number}.jpg"
  rio(url) > rio(filename)
  i+=1
  puts i
end

