(import "./part1" :as part1)
(import "./parse" :as parse)
(import "./util" :as util)

# Pick all the won copies for a given card from the collection of cards
(defn get-copies [card cards]
  (let [matches (part1/match-count card)
        start (get card :card)
        end (+ start matches)]
    (map (fn [i] (get cards i)) (range start end))))

# Update the counts on the won cards, given the current card
(defn update-counts [card copies]
  (loop [copy :in copies]
    (let [card-count (get card :count)
          orig-count (get copy :count)]
      (put copy :count (+ orig-count card-count)))))

(defn part2 [input]
  (let [cards (parse/parse-input (string/trim input))]
    (loop [card :in cards]
      (let [copies (get-copies card cards)]
        (update-counts card copies)))
    (sum (map (fn [card] (get card :count)) cards))))

(defn main [& args]
  (let [input (slurp "./input.txt")]
    (print "Part 2: " (part2 input))))
