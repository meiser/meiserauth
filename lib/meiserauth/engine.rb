module Meiserauth
  class Engine < ::Rails::Engine
    isolate_namespace Meiserauth
    
    engine_name :meiserauth
     
        
    initializer "meiserauth.load_ldap_config" do |app|
     LDAP_CONFIG = YAML.load_file("#{Rails.root.join("config/ldap.yml")}")[Rails.env]
    end
   


    initializer 'meiserauth.app_controller' do |app|
     ActiveSupport.on_load(:action_controller) do
      extend Meiserauth::ClassMethods
      include Meiserauth::InstanceMethods
      helper Meiserauth::ActionViewHelper
     end
    end
    
    
  end
end
