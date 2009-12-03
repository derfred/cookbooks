define :rabbitmq_vhost do
  execute "create #{params[:vhost_name]} rabbitmq vhost" do
    command "rabbitmqctl add_vhost #{params[:vhost_name]}"
    not_if do
      `rabbitmqctl list_vhosts`.split("\n").include?(params[:vhost_name])
    end
  end
end
