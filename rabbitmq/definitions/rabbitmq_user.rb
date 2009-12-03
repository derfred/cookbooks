define :rabbitmq_user do
  execute "create #{params[:user_name]} rabbitmq user" do
    command "rabbitmqctl add_user #{params[:user_name]} #{params[:password]}"
    not_if do
      `rabbitmqctl list_users`.split("\n").include?(params[:user_name])
    end
  end
end
