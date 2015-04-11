class window.BankRoll extends Backbone.Model
  initialize: ->
    @set 'chips', 1000
    @set 'bet', 0
    @set 'betSet', false

  changeBet: (add) ->
    chips = @get('chips')
    bet = @get('bet')
    if bet + add >= 0 and chips >= add
      @set 'chips', chips - add
      @set 'bet', bet +  add

  setBet: =>
    if @get('bet') > 0
      @set 'betSet', true


