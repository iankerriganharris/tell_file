module ShowHelper
	class Version_Info
		def initialize(version)
			@version = version
		end

		def version
			@version
		end
	end

	class System_Info
		def initialize(system_name, model)
			@system_name = system_name
			@model = model
		end

		def system_name
			@system_name
		end

		def model
			@model
		end
	end

	class Interface
		def initialize(num, name, status, ipv4_address, netmask, default_gateway)
			@num = num
			@name = name
			@status = status
			@ipv4_address = ipv4_address
			@netmask = netmask
			@default_gateway = default_gateway
		end

		def num
			@num
		end

		def name
			@name
		end

		def status
			@status
		end
		
		def ipv4_address
			@ipv4_address
		end

		def netmask
			@netmask
		end

		def default_gateway
			@default_gateway
		end
	end

	def diagram_interfaces(interface_array)
		
	end
end
