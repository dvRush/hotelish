ActiveAdmin.register Accommodation do
  permit_params :title, :description, :type, :value, :available
end
