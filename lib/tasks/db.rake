namespace :db do
  desc "clean seeds and download images"
  task migrate_seeds: :environment do
    Post.all.each do |p|
      p.download_images
    end
    
    Brand.all.each do |b|
      b.download_images
    end
    
  end

end
