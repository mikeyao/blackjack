# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->

    @set 'deck', deck = new Deck()
    @set 'bankRoll', bankRoll = new BankRoll()

    @get('bankRoll').on 'betPlaced', =>
      @newGame()

  getResult: =>
    playerScore = @get('playerHand').getScore()
    dealerScore = @get('dealerHand').getScore()
    if (dealerScore > 21) || (dealerScore < playerScore <= 21)
      @set 'result', 'win'
      'win'
    else if playerScore is dealerScore
      @set 'result', 'push'
      'push'
    else
      @set 'result', 'lose'
      'lose'

  newGame: =>
    deck = @get 'deck'
    bankRoll = @get 'bankRoll'
    @set 'deck', deck = new Deck() if deck.length < 26
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @trigger('handsDealt')
    @set 'result', null
    @get('playerHand').on 'stand', =>
      @get('dealerHand').flip()
      @get('dealerHand').dealerPlay()
    @get('dealerHand').on 'end', =>
      @endGame()
    @get('playerHand').on 'end', =>
      @endGame()

  endGame: =>
    result = @getResult()
    console.log(result)
    @get('bankRoll').updateChips(result)
    @trigger('chipsUpdated')
