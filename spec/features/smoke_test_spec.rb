require 'spec_helper'

describe 'Smoke test' do
  it 'should render the root path' do
    visit root_path
    expect(page.status_code).to eq 200
  end
end
