Rails.application.config.middleware.use OmniAuth::Builder do
  
  if Rails.env = "development"
  	provider :twitter, 'Oz3xNAgL2equQNBYkEWFw', 'xC1CGmxCH0FvJbkxt1F3wWbcuc9EIH0ZFTUX0YJmLqA'
  	provider :facebook, '224049387650906', 'e8e33bd125343a6107f7220f046b7203',  {:scope => 'publish_stream,email', :client_options => {:ssl => {:ca_path => '/etc/ssl/certs'}}}
  else
  	provider :twitter, 'VZNx04Rs1aP3qdvKccpxsg', 'XfkcQM8UIab8bR7u9wnTqYbXjrVXv0tCSJJZTOZsMk'
  	provider :facebook, '224049387650906', 'e8e33bd125343a6107f7220f046b7203',  {:scope => 'publish_stream,email', :client_options => {:ssl => {:ca_path => '/etc/ssl/certs'}}}
  end
end