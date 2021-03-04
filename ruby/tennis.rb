
class TennisGame1
  EQUAL_SCORES_NAMES = {
    0 => 'Love-All',
    1 => 'Fifteen-All',
    2 => 'Thirty-All'
  }

  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end

  def won_point(playerName)
    if playerName == 'player1'
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def compute_score(winnerPlayer, loserPlayer)
    if (winnerPlayer.points >= 4)
      if winnerPlayer.points - loserPlayer.points > 1
        return "Win for #{winnerPlayer.name}"
      else
        return "Advantage #{winnerPlayer.name}"
      end
    end
  end

  def score
    result = ''
    tempScore = 0
    if @p1points == @p2points
      result = EQUAL_SCORES_NAMES.fetch(@p1points, 'Deuce')
    elsif (@p1points >= 4) || (@p2points >= 4)
      minusResult = @p1points - @p2points
      result = if minusResult == 1
                 'Advantage player1'
               elsif minusResult == -1
                 'Advantage player2'
               elsif minusResult >= 2
                 'Win for player1'
               else
                 'Win for player2'
               end
    else
      (1...3).each do |i|
        if i == 1
          tempScore = @p1points
        else
          result += '-'
          tempScore = @p2points
        end
        result += {
          0 => 'Love',
          1 => 'Fifteen',
          2 => 'Thirty',
          3 => 'Forty'
        }[tempScore]
      end
    end
    result
  end
end

class TennisGame2
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end

  def won_point(playerName)
    if playerName == @player1Name
      p1Score
    else
      p2Score
    end
  end

  def score
    result = ''
    if (@p1points == @p2points) && (@p1points < 3)
      result = 'Love' if @p1points.zero?
      result = 'Fifteen' if @p1points == 1
      result = 'Thirty' if @p1points == 2
      result += '-All'
    end
    result = 'Deuce' if (@p1points == @p2points) && (@p1points > 2)

    p1res = ''
    p2res = ''
    if @p1points.positive? && @p2points.zero?
      p1res = 'Fifteen' if @p1points == 1
      p1res = 'Thirty' if @p1points == 2
      p1res = 'Forty' if @p1points == 3
      p2res = 'Love'
      result = "#{p1res}-#{p2res}"
    end
    if @p2points.positive? && @p1points.zero?
      p2res = 'Fifteen' if @p2points == 1
      p2res = 'Thirty' if @p2points == 2
      p2res = 'Forty' if @p2points == 3

      p1res = 'Love'
      result = "#{p1res}-#{p2res}"
    end

    if (@p1points > @p2points) && (@p1points < 4)
      p1res = 'Thirty' if @p1points == 2
      p1res = 'Forty' if @p1points == 3
      p2res = 'Fifteen' if @p2points == 1
      p2res = 'Thirty' if @p2points == 2
      result = "#{p1res}-#{p2res}"
    end
    if (@p2points > @p1points) && (@p2points < 4)
      p2res = 'Thirty' if @p2points == 2
      p2res = 'Forty' if @p2points == 3
      p1res = 'Fifteen' if @p1points == 1
      p1res = 'Thirty' if @p1points == 2
      result = "#{p1res}-#{p2res}"
    end
    result = "Advantage #{@player1Name}" if (@p1points > @p2points) && (@p2points >= 3)
    result = "Advantage #{@player2Name}" if (@p2points > @p1points) && (@p1points >= 3)
    result = "Win for #{@player1Name}" if (@p1points >= 4) && (@p2points >= 0) && ((@p1points - @p2points) >= 2)
    result = "Win for #{@player2Name}" if (@p2points >= 4) && (@p1points >= 0) && ((@p2points - @p1points) >= 2)
    result
  end

  def setp1Score(number)
    (0..number).each do |_i|
      p1Score
    end
  end

  def setp2Score(number)
    (0..number).each do |_i|
      p2Score
    end
  end

  def p1Score
    @p1points += 1
  end

  def p2Score
    @p2points += 1
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end

  def won_point(n)
    if n == @p1N
      @p1 += 1
    else
      @p2 += 1
    end
  end

  def score
    if ((@p1 < 4) && (@p2 < 4)) && (@p1 + @p2 < 6)
      p = %w[Love Fifteen Thirty Forty]
      s = p[@p1]
      @p1 == @p2 ? "#{s}-All" : "#{s}-#{p[@p2]}"
    elsif @p1 == @p2
      'Deuce'
    else
      s = @p1 > @p2 ? @p1N : @p2N
      (@p1 - @p2) * (@p1 - @p2) == 1 ? "Advantage #{s}" : "Win for #{s}"
    end
  end
end
