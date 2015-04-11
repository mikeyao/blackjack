# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'bankRoll', bankRoll = new BankRoll()
    @newGame()

  getResult: =>
    # debugger
    playerScore = @get('playerHand').getScore()
    dealerScore = @get('dealerHand').getScore()
    if (dealerScore > 21) || (dealerScore < playerScore <= 21)
      @set 'result', 'win'
    else if playerScore is dealerScore
      @set 'result', 'push'
    else
      @set 'result', 'lose'

  newGame: =>
    deck = @get 'deck'
    bankRoll = @get 'bankRoll'
    @set 'deck', deck = new Deck() if deck.length < 26
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @updateChips()
    @set 'result', null
    bankRoll.set 'betSet', false
    bankRoll.set 'bet', 0
    @get('playerHand').on 'stand', =>
      @get('dealerHand').flip()
      @get('dealerHand').dealerPlay()
    @get('dealerHand').on 'end', =>
      @getResult()
    @get('playerHand').on 'end', =>
      @getResult()

  updateChips: =>
    bankRoll = @get 'bankRoll'
    result = @get 'result'
    if result is 'win'
      bankRoll.set 'chips', bankRoll.get('chips') + 2 * bankRoll.get('bet')
    else if result is 'push'
      bankRoll.set 'chips', bankRoll.get('chips') + bankRoll.get('bet')
