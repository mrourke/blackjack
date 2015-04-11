assert = chai.assert

describe 'deck', ->
  game = null
  deck = null
  hand = null

  beforeEach ->
    game = new Game()

  describe 'Decks', ->
    it 'should have a deck', ->
      assert game.get 'deck'

    it 'should have a player hand', ->
      assert game.get 'playerHand'

    it 'should have a dealer hand', ->
      assert game.get 'dealerHand'

    it 'should know when a player busts', ->
      game.playerHand.hit()
      game.playerHand.hit()
      game.playerHand.hit()
      game.playerHand.hit()
      game.playerHand.hit()
      assert 