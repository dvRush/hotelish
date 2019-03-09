ActiveAdmin.register Setting do
  form do |f|
    inputs do
      f.input :name
      f.input :value, as: :string
      f.input :category

      f.has_many :something do |fs|
        fs.input :key
        fs.input :value
      end
    end

    actions
  end

  permit_params :name, :value, :category
end
