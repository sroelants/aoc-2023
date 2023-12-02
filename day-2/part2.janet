(import ./parse :as parse)

# Get the maximum count for a given color for a given game
(defn get-max [game color]
  (max ;(map (fn [view] (get view color)) (get game :views))))

# Get the minimum required set of cubes that could have given rise to this game
# Basically, return the set of the highest values we've seen for each color 
# throughout the game
(defn min-view [game]
  @{ :red   (get-max game :red)
     :blue  (get-max game :blue)
     :green (get-max game :green)})

# Calculate the "power" of a cubeset
(defn power [view] (product (values view)))

(defn part2 [input]
  (let [games (parse/parse-input input)
        min-views (map min-view games)
        powers (map power min-views)]
    (sum powers)))

(defn main [& args]
  (let [input (slurp "./input.txt")]
    (print "Part 2: " (part2 input))))

# Tests

(def test-input (string/trim ``
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
``))

(assert (= (part2 test-input) 2286))
