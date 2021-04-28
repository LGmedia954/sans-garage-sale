
category_list = {
    "Appliances" => {
    },
    "Books" => {
    },
    "Collectibles" => {
    },
    "Computers" => {
    },
    "Electronics" => {
    },
    "Furniture" => {
    },
    "Games" => {
    },
    "Garden" => {
    },
    "Household" => {
    },
    "Kids" => {
    },
    "Media" => {
    },
    "Music" => {
    },
    "Sports" => {
    },
    "Tools" => {
    },
    "Vehicles" => {
    }
  }

category_list.each do |name, category_hash|
  c = Category.new
  c.name = name
  c.save
end