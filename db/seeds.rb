# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")



# Cocktail.create(name:'Ti\' punch')
# Cocktail.create(name:'Black Jack')
# Cocktail.create(name:'Cuba libre')
# Cocktail.create(name:'Long island Iced Tea')


require 'nokogiri'
require 'open-uri'
require 'cloudinary'

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

cpt = 1

(1..14).each do |cpt|
  response = open("http://www.recettes-cocktails.fr/recettes-cocktails/cocktails-rhum-#{cpt}.html")
  doc = Nokogiri::HTML(response, nil, 'utf-8')
  ingredients = []
  url_cocktail = ""
  doc.css('.main section').each do |element|
    category = element.search('h1').text()
    image = "cocktails/cocktail-iscomrima"
    p name = element.search('h2[itemprop=name]').text()
    description = element.search('p[itemprop=description]').text().strip
    ingredients_html = element.search('span[itemprop=ingredients]')

    ingredients_html.each do |i|
      ingredients << i.text
    end

    unless name == ""
      unless element.search('h2 a').first.nil?
        url_cocktail = element.search('h2 a').first.attributes["href"].value
        response2 = open("http://www.recettes-cocktails.fr/recettes-cocktails/#{url_cocktail}")
        doc2 = Nokogiri::HTML(response2, nil, 'utf-8')
        doc2.css('article').each do |e|
          unless e.search('img[itemprop=image]').first.nil?
              respons = Cloudinary::Uploader.upload(e.search('img[itemprop=image]').first.attributes["src"].value,:folder => "cocktails/",:use_filename => true, :unique_filename => false)
              image = respons["public_id"]
          end
          cocktail = Cocktail.create(name: name, description: description, image: image, category: category, upvote: 0)
          unless e.search('span[itemprop=ingredients]').first.nil?
            e.search('span[itemprop=ingredients]').each do |ing|
              if ing.children[0].text.match(/^\d.*/).nil?
                description = "no"
                dose_ingredient = ing.children[0].text.downcase
                if Ingredient.where(name: dose_ingredient).first.nil?
                  ingredient = Ingredient.create!(name: dose_ingredient)
                  ingredient_id = Ingredient.where(name: dose_ingredient).first.id
                else
                  ingredient_id = Ingredient.where(name: dose_ingredient).first.id
                end
              else
                description = ing.children[0].text
                dose_ingredient = ing.children[1].children[0].text.downcase
                if Ingredient.where(name: dose_ingredient).first.nil?
                  ingredient = Ingredient.create!(name: dose_ingredient)
                  ingredient_id = Ingredient.where(name: dose_ingredient).first.id
                else
                  ingredient_id = Ingredient.where(name: dose_ingredient).first.id
                end
              end
              Dose.create!(description: description,cocktail_id: cocktail.id,ingredient_id: ingredient_id)
            end
          end
        end
      end
    end
  end
  cpt += 1
end
