class Movie < ActiveRecord::Base
  def self.ratings_hash
    {'G'=>'1', 'PG'=>'1', 'PG-13'=>'1', 'R'=>'1'}
  end
  
  def self.ratings
    ratings_hash.keys
  end
end
