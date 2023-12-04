(import "./util" :as util)

(defn create-card [card winning scratchies]
  @{ :card card :winning winning :scratchies scratchies :count 1 })

# Parse the card number from the label.
(def label-peg ~(sequence "Card" :s+ (number :d+) ":"))

# Parse a contiguous list of numbers seperated by whitespace
(def numbers-peg ~(cmt (some (sequence :s* (number :d+) :s*))
                       ,(fn [& xs] xs)))

# Parse a contiguous list of numbers seperated by whitespace
#
# Captures the list of numbers as a poor man's set. That is, a sparse,
# 100-element array with the occupied entries set to true.
(def number-set-peg ~(cmt 
                    (some (sequence :s* (number :d+) :s*))
                    ,util/create-set))


# Parse a line into a card object
# Example
# @{ :game 1 :winning @[ false... ]  scratchies [ false... ] }
(def card-peg ~(cmt 
                 (sequence ,label-peg ,number-set-peg "|" ,numbers-peg)
                 ,create-card))

(defn parse-input [input]
  (peg/match ~(some (sequence ,card-peg)) input))
