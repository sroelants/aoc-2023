(import "./parse" :as parse)

(def test-input (string/trim ``
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
``))

(defn adjacent? [obj1 obj2]
  ``
  Check whether two entities are adjacent in the grid or not (including 
  diagonally)
  ``
  (let [dy (- (get obj2 :y) (get obj1 :y))
        x1 (get obj1 :x)
        x2 (get obj2 :x)
        w1 (get obj1 :width)
        w2 (get obj2 :width)]
  (and 
    # delta-y is -1, 0 or 1
    (<= (math/abs dy) 1)
    
    # Either x2 <= (x1 + w1) <= x2 + w2
    # or     x1 <= (x2 + w2) <= x1 + w1
    (or (and (<= x2 (+ x1 w1)) (<= (+ x1 w1) (+ x2 w2)))
        (and (<= x1 (+ x2 w2)) (<= (+ x2 w2) (+ x1 w1)))))))

(defn part-number? [number symbols] 
  ``
  Check whether a number is a part number.
  Part numbers are those for which there's a symbol adjacent to them
  ``
  (some (fn [symbol] (adjacent? number symbol)) symbols))

(defn part1 [input] 
  (let [numbers (parse/parse-numbers input)
        symbols (parse/parse-symbols input)
        part-numbers (filter 
                       (fn [number] (part-number? number symbols)  )
                       numbers)
        vals (map (fn [number] (get number :value)) part-numbers)]
    (sum vals)))

(defn main [& args]
  (let [input (string/trim (slurp "./input.txt"))]
    (print "Part 1:" (part1 input))))
