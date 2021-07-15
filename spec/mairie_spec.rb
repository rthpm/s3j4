require_relative '../lib/mairies'

describe 'the page_query function' do
  it 'fetchs something' do
    expect(page_query).not_to be_nil
  end
end

describe 'the town_count function' do
  it 'returns a size superior to 10' do
    expect(townhall_count(150)).to eq(true)
  end
end

describe 'the town_major function' do
  it 'returns a hash with Fosses' do
    expect(major_town('FOSSES')).to eq(false)
  end
  it 'returns a hash with Cergy' do
    expect(major_town('CERGY')).to eq(false)
  end
  it 'returns a hash with Roissy' do
    expect(major_town('ROISSY EN FRANCE')).to eq(false)
  end
  it 'rejects unknown towns' do
    expect(major_town('BORDEAUX')).to eq(true)
  end
end
