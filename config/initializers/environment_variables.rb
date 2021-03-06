module EnvironmentVariables
  class Application < Rails::Application
    config.before_configuration do
      env_file = Rails.root.join("config", '.env.yml').to_s

      if File.exists?(env_file)
        YAML.load_file(env_file)[Rails.env].each do |key, value|
          ENV[key.to_s] = value
        end
      else
        puts '.env.yml file not found in config'
      end
    end 
  end
end 
