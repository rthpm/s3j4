require_relative '../lib/deputes'

describe 'the page_query function' do
  it 'fetchs something' do
    expect(page_query).not_to be_nil
  end
end

describe 'the depute_count function' do
  it 'returns a size superior to 10' do
    expect(deputes_count(500)).to eq(true)
  end
end
