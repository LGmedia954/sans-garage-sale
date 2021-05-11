require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
#use URI::MailTo::EMAIL_REGEXP

use UsersController
use ItemsController
use CategoriesController
run ApplicationController