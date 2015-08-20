namespace :db do
  desc "clean seeds and download images"
  task migrate_seeds: :environment do
    
    %w[Brand Post Itinerary Stop].each do |klass|
      
      klass.constantize.all.each do |o|
        o.download_images
      end
      
    end
      
  end

end
