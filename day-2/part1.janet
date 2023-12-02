(import ./parse :as parse)

# The constraint given in the problem
(def constraint @{ :red 12 :green 13 :blue 14 })

# Given a single view and a set of constraints, check that the view satisfies
# the constraints.
# Constraints are a color table of the form { :red x :blue y :green z }
(defn validate-view [constraint view]
   (and
     (<= (get view :red)   (get constraint :red))
     (<= (get view :blue)  (get constraint :blue))
     (<= (get view :green) (get constraint :green))))


# Given a game and a set of constraints, check that the entire game (i.e., all 
# its views) satisfy the constraints.
# Constraints are a color table of the form { :red x :blue y :green z }
(defn validate-game [constraint game]
   (let [views (get game :views)
         validate (fn [view] (validate-view constraint view))
         validated (map validate views)]
   (all validate views)))

(defn part1 [input] 
   (let [games (parse/parse-input input)
         validate-game (fn [game] (validate-game constraint game))
         valid-games (filter validate-game games)
         valid-indices (map (fn [game] (get game :number)) valid-games)]
      (sum valid-indices)))

(defn main [& args]
  (let [input (slurp "./input.txt")]
    (print "Part 1: " (part1 input))))

# Tests

(def test-input (string/trim ``
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
``))

(assert (= (part1 test-input) 8))
