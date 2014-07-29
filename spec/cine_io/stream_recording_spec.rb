require 'spec_helper'

describe CineIo::StreamRecording do

  subject { CineIo::StreamRecording.new(:name => 'my name') }

  it 'has some attributes' do
    expect(subject.name).to eq('my name')
  end

end
