# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'result', null
    @get('playerHand').on 'stand', =>
      @get('dealerHand').flip()
      @get('dealerHand').dealerPlay()
    @get('dealerHand').on 'end', =>
      @getResult()
    @get('playerHand').on 'end', =>
      @getResult()

  getResult: =>
    playerScore = @get('playerHand').getScore()
    dealerScore = @get('dealerHand').getScore()
    if dealerScore < playerScore <= 21
      @set 'result', 'win'
    else if playerScore is dealerScore
      @set 'result', 'push'
    else
      @set 'result', 'lose'


