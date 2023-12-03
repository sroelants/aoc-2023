(import "./part1" :as part1)
(import "./parse" :as parse)

(defn part2 [input]
  (let [numbers (parse/parse-numbers input)
        symbols (parse/parse-symbols input)
        stars (filter (fn [symbol] (= (get symbol :value) "*")) symbols)
        adjacents (fn [symbol] (filter (fn [number] (part1/adjacent? number symbol)) numbers))
        gear? (fn [star] (= (length (adjacents star)) 2))
        get-ratio (fn [gear] (product (map (fn [number] (get number :value)) (adjacents gear))))]
    (sum (map get-ratio (filter gear? stars)))))

(defn main [& args]
  (let [input (string/trim (slurp "./input.txt"))]
    (print "Part 2:" (part2 input))))
