module Meiserauth
  class User < ActiveRecord::Base
    
    
      attr_accessor :login_or_email, :default_printer
    
      attr_accessible :password, :login_or_email
    
      serialize :preferences, OpenStruct
    
    
      before_save :convert_email
    
      def convert_email
       self.email = self.email.downcase
      end
    
    
      def self.ldap_auth(key, password=nil)
       return nil if password.empty?
       return User.first if Meiserauth::Engine::LDAP_CONFIG['enabled'] == false
       ldap = initialize_ldap_con
    
       Meiserauth::Engine::LDAP_CONFIG["attributes"].each do |ldap_attribute|
        result = ldap.bind_as(
          :base => Meiserauth::Engine::LDAP_CONFIG['base'],
          :filter => "#{ldap_attribute}=#{key}",
          :password => password
        )
        if result
         puts "Authenticated with #{ldap_attribute}"
         puts "DN: #{result.first.dn}"
         puts "MAIL: #{result.first["mail"].first}"
    
         unless user = User.find_by_email(result.first[:mail].first.downcase)
          user = User.new
          user.login = result.first["sAMAccountName"].first
          user.email = result.first["mail"].first
         end
         return user
        end
       # END result
       end
    
       return nil
    
       rescue
    
        return nil
    
      end
    
      class << self
    
      private
    
        def initialize_ldap_con
          options = { :host => Meiserauth::Engine::LDAP_CONFIG['host'],
                      :port => Meiserauth::Engine::LDAP_CONFIG['port'],
                      :encryption => (Meiserauth::Engine::LDAP_CONFIG['ssl'] ? :simple_tls : nil),
                      :auth => {
                        :method => :simple,
                        :username => Meiserauth::Engine::LDAP_CONFIG['admin_user'],
                        :password => Meiserauth::Engine::LDAP_CONFIG['admin_password']
                      }
          }
          Net::LDAP.new options
        end
    
  	end
    
    
  end
end
