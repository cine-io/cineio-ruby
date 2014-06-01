require 'spec_helper'

describe CineIo::Project do

  subject { CineIo::Project.new(:id => 'my id') }

  it 'has some attributes' do
    expect(subject.id).to eq('my id')
  end

end
