require "#{Rails.root}/app/modules/ShowHelper.rb"
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
		@test = Array.new	
	#	@test_hash = Hash.from_xml(@raw_contents.to_s)
	#	puts @test_hash

		@raw_contents.css("interface physical-if").each do |node|
			@interface_array << Hash.from_xml(node.to_s)
		end

		@object_array = Array.new
		
		@interface_array.each do |interface| 
			interface.values.each do |key|
					@if_num = key.slice("if_num").values
					@if_dev_name = key.slice("if_dev_name").values
					@ip = key.slice("ip").values
					@netmask = key.slice("netmask").values
					@default_gateway = key.slice("default_gateway").values
					@object_array << ShowHelper::Interface.new(@if_num, @if_dev_name, @ip, @netmask, @default_gateway)
			end
		end

		puts @object_array[0].name
	#	@interface_array.each do |node|

	end

	private

	def upload_params
		params.require(:upload).permit(:title, :file)
	end

end
