require 'Docking_station'
require 'bike'

describe DockingStation do 

	let (:bike) { double :bike, broken?: false }
	let (:station) {DockingStation.new}
	let (:broken_bike) { double :bike, broken?: true }


	it 'can tell us when there are no bikes available' do 
		expect(station.bike_available?).not_to be_true
	end

	it 'can accept a bike' do
		expect(station.dock(bike)).to eq [bike]
	end

	it 'can release a bike' do 
		station.dock(bike)
		expect(station.release).to eq bike 
	end

	it 'does not release bike if none available' do
		expect(station.release).to eq nil
	end

	it 'does not release bike if bike is broken' do
		station.dock broken_bike
		expect(station.release).to eq nil
	end

	it 'selects broken bikes' do
		station.dock broken_bike
		expect(station.broken_bikes).to eq [broken_bike]
	end

	it 'releases broken bike to the van' do 
		station.dock broken_bike
		expect(station.release_to_van).to eq [broken_bike]
	end

	it 'after releases bike, bike is no longer in store' do
		station.dock broken_bike
		station.release_to_van
		expect(station.broken_bikes).to eq []
	end

	it 'releases multiple broken bikes to the van' do
		bike1 = broken_bike
		bike2 = double :bike, broken?: true
		station.dock bike1
		station.dock bike2
		expect(station.release_to_van).to eq [bike1, bike2]
	end

end 