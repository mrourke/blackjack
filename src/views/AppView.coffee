class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="winner-announcement"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()

  initialize: ->
    @model.get('game').get('playerHand').on 'bust', =>
      console.log 'busted'
      $('.hit-button, .stand-button').toggle()
      #TODO add play again functionality

    @model.get('game').on 'playerWon', ->
      $('.winner-announcement').text 'Player wins!'

    @model.get('game').on 'dealerWon', ->
      $('.winner-announcement').text 'Dealer wins!'

    @model.get('game').on 'push', ->
      $('.winner-announcement').text 'Tie game!'

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get('playerHand')).el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get('dealerHand')).el
    

