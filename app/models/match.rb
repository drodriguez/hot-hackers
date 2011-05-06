require 'digest/sha1'

class Match
  K_FACTOR = 32
  DESVSTD  = 150

  attr_accessor :left_hacker, :right_hacker, :signature, :token

  def initialize
    num_hackers = Hacker.count
    left_offset = right_offset = rand(num_hackers)
    self.left_hacker = Hacker.first :offset => left_offset

    # Select a second hacker with a comparable level to the first
    num_hackers, limit = 0, 0
    while num_hackers == 0
      limit += DESVSTD
      num_hackers = Hacker.where('ranking > ? and ranking < ?',
                                self.left_hacker.ranking - limit,
                                self.left_hacker.ranking + limit).count
    end
    right_offset = rand(num_hackers) until left_offset != right_offset
    self.right_hacker = Hacker.first :offset => right_offset

    self.token = SecureRandom.hex(10)
    self.signature = self.class.calculate_signature(self.left_hacker.id,
                                                    self.right_hacker.id,
                                                    self.token)
  end

  def self.calculate_rankings!(match, match_token)
    if match[:signature] != self.calculate_signature(match[:left_hacker_id],
                                                     match[:right_hacker_id],
                                                     match_token)
      raise InvalidRequestError
    end

    left_hacker = Hacker.find match[:left_hacker_id]
    right_hacker = Hacker.find match[:right_hacker_id]
    winner = match[:winner].to_i

    q_left = 10**(left_hacker.ranking / 400.0)
    q_right = 10**(right_hacker.ranking / 400.0)
    denominator = q_left + q_right
    e_left = q_left / denominator
    e_right = q_right / denominator

    s_left, s_right = left_hacker.id == winner ? [1, 0] : [0, 1]
    Hacker.transaction do
      Hacker.update_all(['ranking = ranking + ?', (K_FACTOR * (s_left - e_left)).to_i],
                        :id => left_hacker.id)
      Hacker.update_all(['ranking = ranking + ?', (K_FACTOR * (s_right - e_right)).to_i],
                        :id => right_hacker.id)
    end

    left_hacker.id == winner ? left_hacker : right_hacker
  end

  def self.calculate_signature(left_id, right_id, match_token)
    Digest::SHA1.hexdigest("#{match_token}---#{left_id}---#{right_id}")
  end
end
