class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    newCard = @deck.pop()
    @add(newCard)
    @trigger('end') if @playerScore() > 21
    newCard

  stand: ->
    # console.log('stand triggered in Hand Model')
    @trigger('stand')

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  flip: ->
    # console.log('flip triggered in Hand Model')
    @at(0).flip()

  dealerPlay: =>
    # flip
    # @flip()
    score = @dealerScore()
    while score < 17
      @hit()
      score = @dealerScore()
    @trigger('end')

  getScore: =>
    if @isDealer
      @dealerScore()
    else
      @playerScore()


  dealerScore: =>
    scores = @scores()
    if scores[0] is scores[1]
      scores[0]
    else
      if 18 <= scores[1] <= 21
        scores[1]
      else
        scores[0]

  playerScore: =>
    scores = @scores()
    if scores[1] <= 21
      scores[1]
    else
      scores[0]
