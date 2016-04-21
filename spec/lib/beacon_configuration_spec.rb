require 'spec_helper'

describe BeaconConfiguration do
  it 'loads the defaults in config.yml.example' do
    expect(described_class.upload_storage).to eq 'file'
  end
end
