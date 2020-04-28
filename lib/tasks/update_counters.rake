desc "Update all counters cache"
task :update_counters => [ :environment ] do
  PaymentMethod.pluck(:id).each do |id|
    PaymentMethod.reset_counters id, :reservations
  end

  Customer.pluck(:id).each do |id|
    Customer.reset_counters id, :reservations
  end

  Accommodation.pluck(:id).each do |id|
    Accommodation.reset_counters id, :reservations
  end

  ContactSource.pluck(:id).each do |id|
    ContactSource.reset_counters id, :reservations, :customers
  end

  AccommodationType.pluck(:id).each do |id|
    AccommodationType.reset_counters id, :accommodations
  end
end
