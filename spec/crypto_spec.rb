require_relative '../lib/crypto'

describe 'the crypto_query function' do
  it 'fetchs something' do
    expect(page_query).not_to be_nil
  end
end

describe 'the crypto_count function' do
  it 'returns a size superior to 10' do
    expect(crypto_count(10)).to eq(true)
  end
end

describe 'the crypto_major function' do
  it 'returns a hash with BTC' do
    expect(crypto_major('BTC')).to eq(false)
  end
  it 'returns a hash with DOGE' do
    expect(crypto_major('DOGE')).to eq(false)
  end
  it 'returns a hash with ETH' do
    expect(crypto_major('ETH')).to eq(false)
  end
  it 'rejects unknown currency' do
    expect(crypto_major('LUSTUCRU')).to eq(true)
  end
end
