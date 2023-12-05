(import "./parse" :as parse)
(import "./part1" :as part1)

(defn min-by [fun { :start start :end end }]
  (var min-val (fun start))
  (for i start end 
    (let [next-val (fun i)]
      (if (< next-val min-val)
        (set min-val next-val))))
  min-val)

(defn part2 [input]
  (let [{ :seeds seed-ranges :maps maps } (parse/parse-input-part2 input)
        apply-all (fn [seed] (part1/apply-all seed maps))
        min-of-range (fn [seed-range] (min-by apply-all seed-range))
        min-of-each (map min-of-range seed-ranges)]
    (min-of min-of-each)))


# Ugh, this implementation works just fine (for the test-input, at least
# But it's way too slow to iterate over all the seed ranges. They're huge.
# The smart thing to do is to map entire range boundaries, where a single range
# might get mapped into any number of ranges, which then all need to get mapped
# by the next rule.
# That's still exponential growth, which I'm not excited about, but hopefully 
# it stays under control for longer.

(defn main [& args]
  (let [input (slurp "./input.txt")]
    (print "Part 2: " (part2 input))))
