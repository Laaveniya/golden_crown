require './lib/southeros'

describe 'decrypt_secret_messages' do
  it 'manipulates the secrets message and computes the alies of rulers' do
    conquer_attempts = [
      "Air, “Let’s swing the sword together”",
      "Land, “Die or play the tame of thrones”",
      "Ice, “Ahoy! Fight for me with men and money”",
      "Water, “Summer is coming”",
      "Fire, “Drag on Martin!”"
    ]
    southeros = Southeros.new
    southeros.decrypt_secret_messages(conquer_attempts)
    expect(southeros.alies).to eq(['Air','Land','Ice','Fire'])
  end
end
