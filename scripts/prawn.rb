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

# Nuevos settings
pdf.font_size 16
pdf.fill_color "cc6600"

files = Dir.glob("#{File.dirname(__FILE__)}/../images/[0-9]*.jpg")
files = files.sort do |a,b|
  a.split('/').last.to_i <=> b.split('/').last.to_i
end

i = 0
while i < files.size

  pdf.start_new_page

  if File.file?(files[i])
    i0 = files[i]
    width = 240
    x_pos = (total_width - width) / 2
    pdf.image i0, :at => [  10, (total_height) - 40 ], :width => width

    pdf.bounding_box([10, total_height - 20], :width => 60, :height => 20) do
      pdf.text "##{files[i].split('/').last.split('.').first}"
    end
  end

  if File.file?(files[i+1])
    i1 = files[i+1]
    width = 240
    x_pos = (total_width - width) / 2
    pdf.image i1, :at => [  (total_width / 2 ) + 10 , (total_height / 2) + 40 ], :width => width

    pdf.bounding_box([(total_width / 2 ) + 10, (total_height / 2) + 60], :width => 60, :height => 20) do
      pdf.text "##{files[i+1].split('/').last.split('.').first}"
    end
  end
  
  i+=2
  
end


# pdf.number_pages "<page> / <total>"
pdf.render_file "pdf/things_we_forgetv1.pdf"

