class UserAgentDecoder
	require 'yaml'

	attr_reader :result
	attr_writer :user_agent_string

	def initialize user_agent_string = nil
		load_rules

		@result = {
			os: {
				token: '',
				name: '',
				version: '',
				version_name: ''
			},
			browser: {
				name: '',
				version: ''
			}
		}

		if user_agent_string && user_agent_string.strip != ''
			@user_agent_string = user_agent_string
		end
	end

	def parse
		find_os
		find_os_version_name
		find_browser

		@result
	end

	def find_os
		catch :found_os do
			@rules['os'].each do | token, os |
				os['regex'].each do | regex |

					matches = Regexp.new(regex, 'i').match @user_agent_string

					if matches
						@result[:os][:token] = token
						@result[:os][:name] = os['name']
						
						if matches[1]
							@result[:os][:version] = matches[1].gsub '_', '.'
						end

						throw :found_os
					end
				end
			end
		end
	end

	def find_os_version_name
		catch :found_os_version_name do
			version_names = @rules['os_version_names'][@result[:os][:token]]
			
			if version_names 
				version_names.each do | version_name |
					if Regexp.new("^#{version_name['version']}").match @result[:os][:version]
						@result[:os][:version_name] = version_name['name']

						throw :found_os_version_name
					end
				end
			end
		end
	end

	def find_browser
		catch :found_browser do
			if @result[:os][:token] && @result[:os][:token].strip != ''
				browsers = @rules['os_browsers'][@result[:os][:token]].each do | browser |
					@rules['browsers'][browser]['regex'].each do | regex |
						matches = Regexp.new(regex, 'i').match @user_agent_string

						if matches
							@result[:browser][:name] = @rules['browsers'][browser]['name']
							
							if matches[1]
								@result[:browser][:version] = matches[1].gsub '_', '.'
							end

							throw :found_browser
						end
					end
				end
			end
		end
	end

	def load_rules
		@rules = YAML.load_file "lib/user_agent_rules.yml"

    # Add fallbacks
    # OS fallback
    @rules['os']['fallback'] = { 'name' => 'Unknown OS', 'regex' => [''] }
    
    # Browser fallback
    @rules['browsers']['fallback'] = { 'name' => 'Unknown Browser', 'regex' => [''] }

    # Fallback broswser to every os_browser combinations
    @rules['os_browsers'].each do | os, browsers |
       @rules['os_browsers'][os] << 'fallback'
    end

    # Add all browsers to the fallback os
    @rules['os_browsers']['fallback'] = []

    @rules['browsers'].each do | browser, info |
      @rules['os_browsers']['fallback'] << browser
    end
	end
end