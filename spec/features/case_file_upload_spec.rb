require 'rails_helper'

RSpec.feature 'File upload' do
  scenario 'uploading a digital case file' do
    visit case_files_path
    attach_file 'File', File.expand_path('../../fixtures/minimal.json', __FILE__)
    click_button 'Upload'

    expect(page).to have_text('date is required')
  end
end
