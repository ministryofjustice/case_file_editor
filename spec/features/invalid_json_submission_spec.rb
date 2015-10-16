require 'rails_helper'

RSpec.feature 'A client submits JSON' do
  scenario 'submitting invalid JSON' do
    broken_json = '!@#$#@$%'

    curb = post_data(case_files_path, broken_json)

    expect(curb.response_code).to eq(400)
    expect(curb.content_type).to match(%r{application/json})
    expect(curb.body_str).to match(/JSON/)
  end

  def post_data(path, payload)
    host = Capybara.current_session.server.host
    port = Capybara.current_session.server.port
    Curl.post("http://#{host}:#{port}#{path}", payload) do |curl|
      curl.headers['Accept'] = 'application/json'
      curl.headers['Content-Type'] = 'application/json'
    end
  end
end
