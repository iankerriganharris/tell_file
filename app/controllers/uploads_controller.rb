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
		@interfaces = @raw_contents.xpath("//interface//if-item-list//item//physical-if").first
	end

	private

	def upload_params
		params.require(:upload).permit(:title, :file)
	end

end
