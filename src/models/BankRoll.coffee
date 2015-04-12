class window.BankRoll extends Backbone.Model
  initialize: ->
    @set 'chips', 1000
    @resetChips()

  changeBet: (add) ->
    chips = @get('chips')
    bet = @get('bet')
    if bet + add >= 0 and chips >= add
      @set 'chips', chips - add
      @set 'bet', bet +  add

  setBet: =>
    if @get('bet') > 0 and @get('betSet') is false
      @set 'betSet', true
      @trigger 'betPlaced'

  updateChips: (result) =>
    if result is 'win'
      @set 'chips', @get('chips') + 2 * @get('bet')
    else if result is 'push'
      @set 'chips', @get('chips') + @get('bet')
    @resetChips()

  resetChips: =>
    @set 'bet', 0
    @set 'betSet', false
