# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
lavender = Product.find_or_create_by(product_code: "001", name: "Lavender heart", price_pennies: 925)
Product.find_or_create_by(product_code: "002", name: "Personalised cufflinks", price_pennies: 4500)
Product.find_or_create_by(product_code: "003", name: "Kids T-shirt", price_pennies: 1995)

GeneralLimitPromotion.create(limit_pennies: 6000, over_limit_discount: 10)
ProductPromotion.create(product: lavender, quantity: 2, reduced_price_pennies: 850)