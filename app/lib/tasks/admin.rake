namespace :admin do

  desc "Create an admin user"
  task :create => :environment do
    User.create!(
      email: ENV['EMAIL'],
      first_name: ENV['FIRST_NAME'],
      last_name: ENV['LAST_NAME'],
      password: ENV['PASSWORD'],
      admin: true
      )
  end
end
