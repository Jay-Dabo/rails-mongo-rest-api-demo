class API::V1::DocumentTemplatesController < ApplicationController
  before_action :set_document_template, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token, if: Proc.new { |c| c.request.format == 'application/json' }

  def index
    @document_templates = DocumentTemplate.all
    respond_to do |format|
      format.json { render json: @document_templates }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @document_template }
    end
  end

  def create
    @document_template = DocumentTemplate.new(document_template_params)

    respond_to do |format|
      if @document_template.save
        format.json { render json: @document_template }
      else
        format.json { render json: @document_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @document_template.update(document_template_params)
        format.json { head :no_content }
      else
        format.json { render json: @document_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document_template.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_template
      @document_template = DocumentTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_template_params
      content = params.require(:document_template).fetch(:content, nil).try(:permit!)
      params.require(:document_template).permit(:type, :name, :description, :is_scan, :content).merge(content: content)
    end
end
