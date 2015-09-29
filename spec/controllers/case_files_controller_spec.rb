require 'rails_helper'

RSpec.describe CaseFilesController, type: :controller do
  let(:attributes) {
    {
      raw: Rack::Test::UploadedFile.new(
        Rails.root.join("spec/fixtures/#{json}"))
    }
  }
  let(:json) { 'minimal.json' }

  describe 'GET #index' do
    it 'renders the "index" template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'assigns an upload' do
        post :create, case_file: attributes
        expect(assigns(:upload)).to be_a(CaseFileUpload)
      end
    end

    context 'with invalid JSON' do
      let(:json) { 'garbage.json' }

      it 'assigns an upload' do
        post :create, case_file: attributes
        expect(assigns(:upload)).to be_a(CaseFileUpload)
      end
    end
  end
end
