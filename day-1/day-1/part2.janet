(defn substrings [line] 
  (map (fn [i] (string/slice line i)) (range 0 (length line))))


(defn str->num [str] 
  (int/to-number (int/u64 str)))

(def digit-peg (peg/compile ~(choice
                               (replace "one"   1)
                               (replace "two"   2)
                               (replace "three" 3)
                               (replace "four"  4)
                               (replace "five"  5)
                               (replace "six"   6)
                               (replace "seven" 7)
                               (replace "eight" 8)
                               (replace "nine"  9)
                               (replace "zero"  0)
                               (replace (capture :d) ,str->num)
                               :a)))

# Parse the first digit, either numeric or spelled out, as an int
(defn parse-digit [str]
  (first (peg/match digit-peg str)))

(defn parse-digits [line] 
  (let [substrs (substrings line)
        digits (map parse-digit substrs)]
    (filter (comp not nil?) digits)))

# Combine a list of numbers by putting the first and last digit together to 
# get a new two-digit number.
(defn combine [digits]
  (+ (* 10 (first digits)) (last digits)))

# # Part 2: For every line, replace number strings with actual digits, combine 
# # the first and last digits in the line and  sum up to get the result
(defn part2 [input]
  (let [lines (string/split "\n" input)
        digits (map parse-digits lines)
        combined (map combine digits)]
    (sum combined)))

(defn main
  [& args]
  (let [input (string/trim (slurp "./input.txt"))]
    (print (part2 input))))
