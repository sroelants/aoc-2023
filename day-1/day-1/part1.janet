# PEG that captures any digits in an alphanumeric string
(def filter-ints (peg/compile '(some
                                 (choice 
                                   :a 
                                   (capture :d)))))

# Convert an array of integer strings into an array of integers
(defn parse-ints [line] 
  (let [ints (peg/match filter-ints line)]
     (map int/to-number (map int/u64 ints))))

# Combine a list of numbers by putting the first and last digit together to 
# get a new two-digit number.
(defn combine [ints]
  (+ (* 10 (first ints)) (last ints)))

# Part 1: For every line, combine the first and last digits in the line and 
# sum up to get the result
(defn part1 [input]
  (let [lines (string/split "\n" input)
        lists (map parse-ints lines)
        combined (map combine lists)]
    (sum combined)))

(defn main
  [& args]
  (let [input (string/trim (slurp "./input.txt"))]
    (print (part1 input))))
