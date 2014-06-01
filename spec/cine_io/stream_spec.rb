require 'spec_helper'

describe CineIo::Stream do

  subject { CineIo::Stream.new(id: 'my id') }

  it 'has some attributes' do
    expect(subject.id).to eq('my id')
  end

end
