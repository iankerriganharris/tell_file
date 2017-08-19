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
		@interface_array = Array.new

		@raw_contents.css("interface physical-if").each do |node|
			@interface_array << Hash.from_xml(node.to_s)
		end

		@object_array = Array.new
		
		@interface_array.each do |interface| 
			interface.values.each do |key|
					@if_num = key.slice("if_num").values[0]
					@if_dev_name = key.slice("if_dev_name").values[0]
					@ip = key.slice("ip").values[0]
					@netmask = key.slice("netmask").values[0]
					@default_gateway = key.slice("default_gateway").values[0]
					@object_array << ShowHelper::Interface.new(@if_num, @if_dev_name, @ip, @netmask, @default_gateway)
			end
		end

		@sorted_object_array = @object_array.sort_by(&:num)

	end

	private

	def upload_params
		params.require(:upload).permit(:title, :file)
	end

end
