class window.AppView extends Backbone.View
  template: _.template '
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <div class="buttons">
      <button class="hit-button">Hit</button>
      <button class="stand-button">Stand</button>
      <button class="play-again" style="display: none">Play Again</button>
    </div>
    <div class="winner-announcement"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()
    'click .play-again': -> 
      @model.get('game').initialize()
      $('.winner-announcement').text ''
      @initializePlayerListener()
      @render()

  initialize: ->
    @initializePlayerListener()

    @model.get('game').on 'playerWon', ->
      $('.winner-announcement').text 'Player wins!'
      $('.play-again').toggle()

    @model.get('game').on 'dealerWon', ->
      $('.winner-announcement').text 'Dealer wins!'
      $('.play-again').toggle()

    @model.get('game').on 'push', ->
      $('.winner-announcement').text 'Tie game!'
      $('.play-again').toggle()

    @render()

  initializePlayerListener: ->
    @model.get('game').get('playerHand').on 'bust stand', =>
      $('.hit-button, .stand-button').toggle()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get('dealerHand')).el
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get('playerHand')).el