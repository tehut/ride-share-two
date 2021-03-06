module Rideshare
  class Driver
    attr_reader :driver_id, :name, :vin
    def initialize(trip_hash)
      @driver_id = trip_hash[:driver_id]
      @vin = trip_hash[:vin]
      @name = trip_hash[:name]
      raise MissingIdError.new("That is an invalid driver id") if @driver_id.to_i > 100 || @driver_id.to_i <= 0
      raise InvalidDataError.new("A driver's vin must be 17 characters long") if @vin.length !=17
      raise InvalidDataError.new("All drivers must have a name") if @name.length <= 0

    end

    def self.create_drivers
      hash = {}
      CSV.foreach('support/drivers.csv', {:headers => true, :header_converters=> :symbol}) do |row|
        hash[row[0]] =Driver.new({driver_id:row[0], name:row[1], vin:row[2]})
      end
      return hash
    end


    def self.find_driver(param)

      driver = self.create_drivers.select!{|key,value| key == param.to_s}
      return driver.values[0]
    end

    def all_my_trips(param = @driver_id)
      array = []
      array << Trip.find_by_driver(@driver_id)
      return array.flatten
    end

    def driver_rating
      array = Trip.find_by_driver(@driver_id)
       array.map!{|value| value.rating.to_i}
       return array.reduce(:+)/array.length
    end

  end
end
