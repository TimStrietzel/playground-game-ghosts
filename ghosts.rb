#!/usr/bin/ruby
MAX_GHOSTS = 4
MAX_SUNBEAMS = 9

count_sunbeams = 0

Colors = {0 => 'WHITE', 1 => 'BLACK', 2 => 'RED' , 3 => 'BLUE' , 4 => 'GREEN' , 5 => 'YELLOW'}
Ghosts_in_castle = { "RED" => 0 , "BLUE" => 0 , "GREEN" => 0 }

def get_dice_color
  return Colors[Random.rand(6)]
end;

def all_ghosts_rescued?
  total_ghosts_rescued = 0;
  ["RED","BLUE","GREEN"].each{ |color| 
    total_ghosts_rescued += Ghosts_in_castle[color]
  }
  return total_ghosts_rescued >= (MAX_GHOSTS * 3)
end

def rescue_one_ghost(color)
  Ghosts_in_castle[color] += 1 if Ghosts_in_castle[color] < MAX_GHOSTS
end

def punish_one_ghost(color)
  Ghosts_in_castle[color] -= 1 if Ghosts_in_castle[color] > 0
end

def rescue_best_ghost
  color = Ghosts_in_castle.min_by{|k,v| v}[0].to_s
  rescue_one_ghost(color)
end

def punish_best_ghost
  color = Ghosts_in_castle.max_by{|k,v| v}[0].to_s
  punish_one_ghost(color)
end

def game_won?(count_sunbeams)
  return count_sunbeams < MAX_SUNBEAMS
end

game_rounds = 0
while (count_sunbeams < MAX_SUNBEAMS) && !all_ghosts_rescued? do
  game_rounds += 1
  color = get_dice_color
  case color
    when "BLACK"
      punish_best_ghost
    when "WHITE"
      rescue_best_ghost
    when "YELLOW"
      count_sunbeams += 1  
    else
      rescue_one_ghost(color)
  end
end


puts ""
if game_won?(count_sunbeams)
  puts "You won 💓 after #{game_rounds} rounds."
else
  puts "You lost 💩 after #{game_rounds} rounds."
end
puts ""
puts "rescued ghosts:"
print   "\n🔴 Red     : " * 1 + "👻" * Ghosts_in_castle["RED"]
print   "\n🔵 Blue    : " * 1 + "👻" * Ghosts_in_castle["BLUE"]
print   "\n💚 Green   : " * 1 + "👻" * Ghosts_in_castle["GREEN"]
print "\n\n🌞 Sunrays : " * 1 + "🌞" * count_sunbeams
print "\n\n"
