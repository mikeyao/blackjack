class window.AppView extends Backbone.View
  template: _.template '
    <div class="bankroll-container"></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      if (not @model.get('result') and @model.get('bankRoll').get('betSet'))
        @model.get('playerHand').hit()
    'click .stand-button': ->
      if (not @model.get('result') and @model.get('bankRoll').get('betSet'))
        @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'change:result', =>
      @finish(@model.get 'result') if @model.get 'result'
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bankroll-container').html new BankRollView(model: @model.get 'bankRoll').el

  finish: (result)->
    if confirm("You #{result} /n Do you want to continue?")
      @model.newGame()
    else
      console.log("Do nothing")

