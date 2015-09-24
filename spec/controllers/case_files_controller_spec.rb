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
      it 'assigns a Case to @case' do
        post :create, case_file: attributes
        expect(assigns(:case)).to be_a(Case)
      end

      it 'does not assign anything to @exception' do
        post :create, case_file: attributes
        expect(assigns(:exception)).to be_nil
      end

      it 'assigns the errors to @errors' do
        post :create, case_file: attributes
        expect(assigns(:errors)).to be_a(Hash)
      end

      it 'renders the "create" template' do
        post :create, case_file: attributes
        expect(response).to render_template('create')
      end
    end

    context 'with invalid JSON' do
      let(:json) { 'garbage.json' }

      it 'assigns the exception to @exception' do
        post :create, case_file: attributes
        expect(assigns(:exception)).to be_a(StandardError)
      end

      it 'does not assign anything to @errors' do
        post :create, case_file: attributes
        expect(assigns(:errors)).to be_nil
      end

      it 'renders the "create" template' do
        post :create, case_file: attributes
        expect(response).to render_template('create')
      end
    end
  end
end
