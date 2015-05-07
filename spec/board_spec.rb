require 'board'

describe Board do
  it 'is 10 squares wide' do
    expect(subject.width).to be 10
  end

  it 'is 10 squares high' do
    expect(subject.height).to be 10
  end

  context 'when initialized' do
    it 'has no ships' do
      expect(subject.ships).to be_empty
    end
  end

  describe 'place_ship' do
    let(:ship) { double :ship }

    it 'adds a ship to the board' do
      ship = double :ship
      subject.place_ship ship, :A1
      expect(subject.ships).to include ship
    end

    it 'fails if coordinate is invalid' do
      ship = double :ship

      [:A11, :A0, :K1, :K10].each do |coord|
        expect { subject.place_ship ship, coord }.to raise_error 'Invalid coordinate'
      end
    end
  end

  describe 'receive_shot' do
    it 'fails if coordinate is invalid' do
      [:A11, :A0, :K1, :K10].each do |coord|
        expect { subject.receive_shot coord }.to raise_error 'Invalid coordinate'
      end
    end
    it 'returns :miss for a miss' do
      expect(subject.receive_shot :A1).to be :miss
    end
    it 'returns :hit for a ship' do
      ship = double :ship
      subject.place_ship ship, :A1
      expect(subject.receive_shot :A1).to be :hit
    end
  end
end