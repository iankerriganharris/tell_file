module ShowHelper
	class Interface
		def initialize(num, name, ipv4_address, netmask, default_gateway)
			@num = num
			@name = name
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
