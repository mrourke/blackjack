assert = chai.assert

describe 'Game', ->
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

    it 'should call checkForBusts on card draw', ->
      game.get('playerHand').hit()
      expect('checkForBusts').to.be true; 
      #expect($.ajax.calledOnce).to.be.true;