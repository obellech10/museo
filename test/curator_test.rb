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

end
