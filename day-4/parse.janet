(def test-input (string/trim ``
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
``))

# Janet doesn't have built-in sets, so we're mocking a _very_ space-inefficient
# (but fairly time-efficient!) set by pre-allocating a 100 element array of
# bools for every number.
(defn create-set [& xs] 
  (let [number-set (array/new-filled 100 false)]
    (loop [x :in xs]
      (put number-set x true))
    number-set))

(defn create-card [game winning scratchies]
  @{ :game game :winning winning :scratchies scratchies })

# Check whether a set contains a particular number
(defn contains? [xs x] (get xs x))

# Parse the card number from the label.
(def label-peg ~(sequence "Card " (number :d+) ":"))


# Parse a contiguous list of numbers seperated by whitespace
#
# Captures the list of numbers as a poor man's set. That is, a sparse,
# 100-element array with the occupied entries set to true.
(def numbers-peg ~(cmt 
                    (some (sequence :s* (number :d+) :s*))
                    ,create-set))

# Parse a line into a card object
# Example
# @{ :game 1 :winning @[ false... ]  scratchies [ false... ] }
(def card-peg ~(cmt 
                 (sequence ,label-peg ,numbers-peg "|" ,numbers-peg)
                 ,create-card))

(defn parse-input [input]
  (peg/match ~(some (sequence ,card-peg)) input))
