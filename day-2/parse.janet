# Group a num-color tuple into a structured table
(defn structure-color [num color] 
      @{ (keyword color) (int/to-number (int/u64 num)) })

# Group a number + views tuple into a structured table
(defn structure-game [num & views]
   @{ :number (int/to-number (int/u64 num)) :views views })

# Parse a single color entry into a structured table
# Example: (peg/match color-peg "1 red") -> @{ :red 1 }
(def color-peg ~(cmt (sequence 
                       (capture :d+) 
                       " " 
                       (capture (choice "red" "green" "blue")) 
                       (opt ",")
                       (opt " "))
                    ,structure-color))

# Parse a "view", i.e., a collection of color counts into a structured table
# Example: (peg/match view-peg "1 red, 3 blue, 5 green") -> @{ :red 1 :blue 3 :green 5 }
(def view-peg ~(cmt 
                 (some ,color-peg) 
                 ,(fn [& colors] (merge-into @{ :red 0 :blue 0 :green 0 } ;colors))))

# Parse a game label
# Example: (peg/match game-number-peg "Game 5: 2 red" -> 5
(def game-number-peg ~(sequence "Game " (capture :d+) ": "))


# Parse a game into a list of game number and views
# Example:
# (peg/match game-peg "Game 1: 1 red, 2 blue, 3 green; 4 red, 5 blue, 6 green")
# -> @[ 1 @{ ... } @{ ... }]
(def game-peg ~(sequence 
                      ,game-number-peg
                      (some (sequence ,view-peg (opt ";") (opt " ")))))
                    
# Parse an entire game line into a structured object
# Example: 
# (parse-game "Game 1: 1 red, 2 blue, 3 green; 4 red, 5 blue, 6 green")
# -> { :number 1 :views @[ @{ :red 1 :blue 2 :green 3} @{ :red 4 :blue 5 :green 6 }]}
(defn parse-game [line]
   (structure-game ;(peg/match game-peg (string/trim line))))

(defn parse-input [input]
   (map parse-game (string/split "\n" (string/trim input))))
