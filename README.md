# sans-garage-sale

Sans Garage Sale is a Model-View-Controller (MVC) application built with Ruby, Sinatra, and ActiveRecord, using the updated Corneal gem.

People who live in urban areas might not have a garage, and some shared communities that do offer garage or yard space do not permit residents to hold the open sales that we often see in suburbs and rural areas. This app provides a space where users can post items they are looking to sell or give away.

To use this app, just clone, run rake db:migrate and then run shotgun.

MVC is a software design pattern commonly used for developing user interfaces that divides the program logic into three interconnected elements -- and a separation of concerns.

This project has multiple models, using "has_many" and "belongs_to" relationships. Users can sign up, sign in, and sign out. Unique log in attempts as well as user inputs are checked for validity. Once logged in, a user can create, read, update and delete (CRUD) their posts. A user cannot edit or delete anyone else's information.

Copyright (c) 2021 Leslie G., <a href="https://github.com/LGmedia954/sans-garage-sale/blob/main/LICENSE">MIT License.</a>