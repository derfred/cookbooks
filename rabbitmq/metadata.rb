maintainer        "Frederik Fix"
maintainer_email  "ich@derfred.com"
license           "Apache 2.0"
description       "Installs and configures RabbitMQ server"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version           "0.1"
recipe            "rabbitmq", "RabbitMQ configuration"

%w{debian ubuntu}.each do |os|
  supports os
end

attribute "rabbitmq",
  :display_name => "RabbitMQ Hash",
  :description => "Hash of RabbitMQ attributes",
  :type => "hash"

attribute "rabbitmq/virtual_hosts",
  :display_name => "RabbitMQ virtual hosts",
  :description => "Names of additional vhosts to create",
  :default => []

attribute "rabbitmq/users",
  :display_name => "RabbitMQ user and permissions",
  :description => "definitions of users to create",
  :default => []
