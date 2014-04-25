Rails.configuration.customerio = {
  :site_id      => ENV['f29774dbdcd7e0e8574f'],
  :api_key      => ENV['865c0e31dd4569c28f3e']
}

$customerio = Customerio::Client.new(Rails.configuration.customerio[:site_id], Rails.configuration.customerio[:api_key])