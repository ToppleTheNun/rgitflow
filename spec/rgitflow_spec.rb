RSpec.describe 'RGitFlow' do
  it 'should have a VERSION constant' do
    expect(RGitFlow::VERSION).to_not be_nil
  end
end