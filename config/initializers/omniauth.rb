Rails.application.config.middleware.use OmniAuth::Builder do
  
  if Rails.env == "development"
  	provider :twitter, 'Oz3xNAgL2equQNBYkEWFw', 'xC1CGmxCH0FvJbkxt1F3wWbcuc9EIH0ZFTUX0YJmLqA'
  	provider :facebook, '224049387650906', 'e8e33bd125343a6107f7220f046b7203',  {:scope => 'publish_stream'}
  else
  	provider :twitter, 'VZNx04Rs1aP3qdvKccpxsg', 'XfkcQM8UIab8bR7u9wnTqYbXjrVXv0tCSJJZTOZsMk'
  	provider :facebook, '157999927621589', 'b72e2c73b99ff5959c212461fd21b510',  {:scope => 'publish_stream', :client_options => {:ssl => {:ca_path => '/etc/ssl/certs'}}}
  end
end