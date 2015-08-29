namespace :db do
  desc "clean seeds and download images"
  task migrate_seeds: :environment do
    %w[Brand Post Itinerary Stop Establishment].each do |klass|
      klass.constantize.all.each do |o|
        o.download_images
      end
    end
  end
  
  desc "placeholders for demo"
  task generate_placeholders: :environment do
    %w[Brand Establishment].each do |klass|
      klass.constantize.all.each do |o|
        o.generate_placeholders
        o.download_images
      end
    end
  end

end
