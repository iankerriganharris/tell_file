require "#{Rails.root}/app/modules/show_helper.rb"

class UploadsController < ApplicationController
	def index
		@uploads = Upload.order('created_at')
	end

	def new
		@upload = Upload.new
	end

	def create
		@upload = Upload.new(upload_params)
		if @upload.save
			flash[:note] = "Successfully uploaded."
			redirect_to root_path
		else
			flash[:alert] = "Error uploading."
			render :new
		end
	end

	def show
		@uploaded = Upload.find(params[:id])
		@raw_contents = Nokogiri::XML(Paperclip.io_adapters.for(@uploaded.file).read)
		@version_array = Array.new
		@system_info_array = Array.new
		@interface_array = Array.new

		@raw_contents.css("for-version").each do |node|
			@version_array << Hash.from_xml(node.to_s)
		end

		@raw_contents.css("device-conf").each do |node|
			@system_info_array << Hash.from_xml(node.to_s)
		end

		@raw_contents.css("interface physical-if").each do |node|
			@interface_array << Hash.from_xml(node.to_s)
		end

		@obj_version_array = Array.new

		@version_array.each do |ver|
			ver.values.each do |key|
				@version = key
				@obj_version_array << ShowHelper::Version_Info.new(@version)
			end
		end

		@obj_info_array = Array.new
			
		@system_info_array.each do |info|
			info.values.each do |key|
				@model = key.slice("for_model").values[0]
				@system_name = key.slice("system_name").values[0]
				@obj_info_array << ShowHelper::System_Info.new(@system_name, @model)
			end
		end
		
		@object_array = Array.new

		@interface_array.each do |interface| 
			interface.values.each do |key|
					@if_num = key.slice("if_num").values[0]
					@status = key.slice("enabled").values[0]
					@if_dev_name = key.slice("if_dev_name").values[0]
					@ip = key.slice("ip").values[0]
					@netmask = key.slice("netmask").values[0]
					@default_gateway = key.slice("default_gateway").values[0]
					@object_array << ShowHelper::Interface.new(@if_num, @if_dev_name, @status, @ip, @netmask, @default_gateway)
			end
		end


		@obj_version_array
		@obj_info_array
		@sorted_object_array = @object_array.sort_by(&:num)
	end

	private

	def upload_params
		params.require(:upload).permit(:title, :file, :user_id)
	end

end
