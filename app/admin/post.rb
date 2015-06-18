ActiveAdmin.register Post do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  permit_params :title, :summary, :body
  
  menu label: proc{ (I18n.t "posts").capitalize }
  
  index do |post|
    selectable_column
    column "Title" do |post|
      link_to post.title, admin_post_path(post)
    end
    column :published_at
    actions
  end
  
  index as: :grid do |post|
    link_to image_tag(post.photo ? post.photo.image.thumb('200x100#').url : 'http://placehold.it/200x100'), admin_post_path(post)
  end
  
  index as: :blog do
    title :title
    body :summary
  end
  
  show do
    h2 post.title
    div do
      simple_format post.embedded_body
    end
  end
  
  form do |f|
      inputs 'Details' do
        input :title
        input :published_at, label: "Publish Post At", as: :datepicker
        li "Created at #{f.object.created_at}" unless f.object.new_record?
        input :summary
      end
      panel 'Markup' do
        "The following can be used in the content below..."
      end
      inputs 'Content', :body, :as => :ckeditor
      para "Press cancel to return to the list without saving."
      actions
    end
  
  
end
