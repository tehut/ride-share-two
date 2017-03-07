require 'csv'

class Trip
  attr_reader :all_trips, :driver_id, :rider_id

  def initialize(trip_hash)
    @trip_id = trip_hash[:trip_id]
    @driver_id = trip_hash[:driver_id]
    @rider_id = trip_hash[:rider_id]
    @date = trip_hash[:date]
    @rating = trip_hash[:rating]

  end

  def self.create_all_trips
    hash = {}
    CSV.foreach('support/trips.csv', {:headers => true, :header_converters=> :symbol}) do |row|
     hash[row[0]] = {trip_id:row[0], driver_id:row[1], rider_id:row[2],date:Date.parse(row[3]), rating:row[4]}
    end
    return hash
  end

  # def self.view
  #   @all_trips
  # end
end
Trip.create_all_trips.collect(2){|hash| hash.include(memo)}

# print Trip.driver_id
# print Trip.rider_id
