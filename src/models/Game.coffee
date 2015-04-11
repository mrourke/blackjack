class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    #check for busts on hits
    @get('playerHand').on 'add', => 
      @checkForBusts(@get('playerHand'));

    @get('dealerHand').on 'add', => 
      @checkForBusts(@get('dealerHand'));
 
    # set gameOver if there is a bust evet
    @get('playerHand').on 'bust', => 
      @gameOver()

    @get('dealerHand').on 'bust', => 
      @gameOver()

    # check for stands
    @get('playerHand').on 'stand', => 
      @dealersTurn()

    @get('dealerHand').on 'stand', => 
      @gameOver()
     
    #@dealerHand.on 'change', -> console.log('dealer Busted') #check for dealer hand bust on hits

  dealersTurn: ->
    hand = @get 'dealerHand'
    while hand .scores()[0] < 17   
      hand .hit()
    
    hand .stand()

  gameOver: ->
    console.log 'checking who won'
    playerScore = @get('playerHand').scores()[0]
    dealerScore = @get('dealerHand').scores()[0]
    if playerScore > 21 or (dealerScore > playerScore and dealerScore <= 21)
      @trigger 'dealerWon'

    if dealerScore > 21 or (playerScore > dealerScore and playerScore <= 21)
      @trigger 'playerWon'

    if dealerScore is playerScore
      @trigger 'push'


  checkForBusts: (hand)->
    console.log "checking bust #{hand} #{hand .scores()[0]}"
    if hand .scores()[0] > 21
      hand .trigger 'bust'
