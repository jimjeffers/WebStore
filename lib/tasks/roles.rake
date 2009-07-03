namespace :roles do
  desc "Creates all roles needed for system permissions."
  task :generate => :environment do
    [ :admin, :user, :manager ].each do |role|
        puts "Attempting to generate: #{Role.find_or_create_by_name(role.to_s).name}"
      end
  end
end