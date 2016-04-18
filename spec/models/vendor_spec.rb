require 'spec_helper'

describe Vendor do
  subject { build(:vendor) }
  it { should be_valid }
end
