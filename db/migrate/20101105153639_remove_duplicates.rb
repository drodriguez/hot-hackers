class RemoveDuplicates < ActiveRecord::Migration
  def self.up
    Hacker.all.each do |h|
      h = Hacker.find_by_id(h.id)
      next unless h
      duplicates = Hacker.where("LOWER(username) = ? AND id != ?", h.username.downcase, h.id).all
      if duplicates.any?
        puts "found duplicates for #{h.username}"
        puts h.ranking
        transaction do
          h.ranking = duplicates.inject(h.ranking) { |sum, d| sum += d.ranking } / (duplicates.size + 1)
          duplicates.each(&:destroy)
          h.save!
          puts "final ranking: #{h.ranking}"
        end
      end
    end
  end

  def self.down
  end
end
