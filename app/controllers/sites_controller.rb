class SitesController < ApplicationController
    before_action :set_site, only: [:show, :edit, :update, :destroy]

    skip_before_filter  :verify_authenticity_token

    # GET /sites
    # GET /sites.json
    def index
        @sites = Site.all
    end

    # GET /sites/1
    # GET /sites/1.json
    def show
    end

    # GET /sites/new
    def new
        @site = Site.new
    end

    # GET /sites/1/edit
    def edit
    end

    def get_by_chars
        chars = params['chars']
        logger.debug "received an input of #{params['chars']}"
        if /(\d{3}|\D+)/.match( chars )
            @site_array = Reports::SiteReport.get_site_from_chars( chars )
        else
            @site_array = []
        end
    end

    def send_request_message
        phone_value     = params['phone']
        message_value   = params['message']
        puts "Ph:#{phone_value}    msg:#{message_value}"
        increment
    end

    def increment
        @increment_var = Incrementers::RequestIncrementer.new.increment
    end

    def decrement
        @decrement_var = Incrementers::RequestIncrementer.new.decrement
    end

    # POST /sites
    # POST /sites.json
    def create
        @site = Site.new(site_params)

        respond_to do |format|
            if @site.save
                format.html { redirect_to @site, notice: 'Site was successfully created.' }
                format.json { render :show, status: :created, location: @site }
            else
                format.html { render :new }
                format.json { render json: @site.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /sites/1
    # PATCH/PUT /sites/1.json
    def update
        respond_to do |format|
            if @site.update(site_params)
                format.html { redirect_to @site, notice: 'Site was successfully updated.' }
                format.json { render :show, status: :ok, location: @site }
            else
                format.html { render :edit }
                format.json { render json: @site.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /sites/1
    # DELETE /sites/1.json
    # def destroy
    #     @site.destroy
    #     respond_to do |format|
    #         format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
    #         format.json { head :no_content }
    #     end
    # end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
        @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
        params.require(:site).permit(:site_num, :site_name, :telephone_num)
    end
end
