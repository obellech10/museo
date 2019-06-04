require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require 'pry'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < MiniTest::Test

  def setup
    @curator = Curator.new
    @photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    @photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    @photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    @photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    @artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    @artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    @artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
  end

  def test_that_it_exists
    assert_instance_of Curator, @curator
  end

  def test_attributes
    assert_equal [], @curator.artists
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photographs
    boy = @curator.add_photograph(@photo_1)
    moon = @curator.add_photograph(@photo_2)


    assert_equal boy, moon, @curator.photographs
    assert_equal boy.first, @curator.photographs.first
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @curator.photographs.first.name
    assert_equal moon.last, @curator.find_photograph_by_id("2")
  end

  def test_it_can_add_artists
    bresson = @curator.add_artist(@artist_1)
    adams = @curator.add_artist(@artist_2)

    assert_equal bresson, adams, @curator.artists
    assert_equal bresson.first, @curator.artists.first
    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
    assert_equal bresson.first, @curator.find_artist_by_id("1")
  end

  def test_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    arbus_1 = @curator.add_photograph(@photo_3)
    arbus_2 = @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    diane_arbus = @curator.find_artist_by_id("3")
    assert_equal [arbus_1[2], arbus_2[3]], @curator.find_photographs_by_artist(diane_arbus)
  end

  def test_find_artists_with_multiple_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    arbus_1 = @curator.add_photograph(@photo_3)
    arbus_2 = @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    diane_arbus = @curator.find_artist_by_id("3")

    assert_equal [diane_arbus], @curator.artists_with_multiple_photographs
    assert_equal 1, @curator.artists_with_multiple_photographs.length
    assert diane_arbus == @curator.artists_with_multiple_photographs.first
  end

  def test_find_photos_taken_by_artists_from
   @curator.add_photograph(@photo_1)
   adams_1 = @curator.add_photograph(@photo_2)
   arbus_1 = @curator.add_photograph(@photo_3)
   arbus_2 = @curator.add_photograph(@photo_4)
   @curator.add_artist(@artist_1)
   @curator.add_artist(@artist_2)
   @curator.add_artist(@artist_3)

  assert_equal [adams_1, arbus_1, arbus_2], @curator.photographs_taken_by_artist_from("United States")
  end

end
