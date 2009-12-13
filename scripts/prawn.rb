#!/usr/bin/env ruby

require 'rubygems'
require 'ruby-debug'
require 'prawn'

pdf = Prawn::Document.new(:page_size => 'A5', :page_layout => :landscape, :margin => [10, 5, 10, 5])

# Fuente
pdf.font_families.update("Georgia" => { :normal  => "#{File.dirname(__FILE__)}/../fonts/Georgia.ttf" })
pdf.font "Georgia"

# Dimensiones
dimensions = pdf.page_dimensions
total_width, total_height = dimensions[2], dimensions[3]

### Portada
pdf.fill_color "cc6600"
pdf.font_size 30
pdf.bounding_box([(total_width / 2) - 130, total_height - 100], :width => 400, :height => 100) do
  pdf.text "— things we forget —"
end

# Logo
logo = "#{File.dirname(__FILE__)}/../images/logo.jpg"
width = 450
x_pos = (total_width - width) / 2
pdf.image logo, :at => [  x_pos, total_height - 160 ], :width => width

# url
pdf.fill_color "000000"
pdf.font_size 14
pdf.bounding_box([(total_width / 2) - 100, total_height / 2 - 90], :width => 100, :height => 50) do
  pdf.text "http://thingsweforget.blogspot.com"
end

pdf.start_new_page

# Nuevos settings
pdf.font_size 16
pdf.fill_color "cc6600"

# #0 y #1
i0 = "#{File.dirname(__FILE__)}/../images/0.jpg"
width = 240
x_pos = (total_width - width) / 2
pdf.image i0, :at => [  10, (total_height) - 40 ], :width => width

i1 = "#{File.dirname(__FILE__)}/../images/1.jpg"
width = 240
x_pos = (total_width - width) / 2
pdf.image i1, :at => [  (total_width / 2 ) + 10 , (total_height / 2) + 40 ], :width => width

pdf.bounding_box([10, total_height - 20], :width => 60, :height => 20) do
  pdf.text "#0"
end

pdf.bounding_box([(total_width / 2 ) + 10, (total_height / 2) + 60], :width => 60, :height => 20) do
  pdf.text "#1"
end

pdf.start_new_page

# #2 y #3
i2 = "#{File.dirname(__FILE__)}/../images/2.jpg"
width = 240
x_pos = (total_width - width) / 2
pdf.image i2, :at => [  10, (total_height) - 35 ], :width => width

i3 = "#{File.dirname(__FILE__)}/../images/3.jpg"
width = 240
x_pos = (total_width - width) / 2
pdf.image i3, :at => [  (total_width / 2 ) + 10 , (total_height / 2) + 40 ], :width => width

pdf.bounding_box([10, total_height - 20], :width => 60, :height => 20) do
  pdf.text "#2"
end

pdf.bounding_box([(total_width / 2 ) + 10, (total_height / 2) + 55], :width => 60, :height => 20) do
  pdf.text "#3"
end


# pdf.number_pages "<page> / <total>"
pdf.render_file "pdf/test.pdf"

