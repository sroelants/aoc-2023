(defn create-rule [tgt-start src-start len]
  @{ :src src-start :tgt tgt-start :len len })

(defn create-almanac [seeds & maps] 
  { :seeds seeds :maps maps })

(defn create-seed-range [start len]
  @{ :start start :end (dec (+ start len))})

(def seed-range-peg ~(cmt 
                       (sequence (number :d+) :s (number :d+))
                       ,create-seed-range))

(def seeds-peg ~(cmt 
                  (sequence "seeds: " (some (sequence (number :d+) :s)))
                  ,(fn [& xs] xs)))

(def seed-ranges-peg
  ~(cmt 
    (sequence 
      "seeds: " 
      (some (sequence ,seed-range-peg :s)))
    ,(fn [& xs] xs)))


(def range-peg 
  ~(cmt (some (sequence (number :d+) (any " ")))
        ,create-rule))

(def map-peg 
  ~(cmt (sequence 
          (sequence :a+ "-to-" :a+ " map:\n")
          (some (sequence ,range-peg (opt "\n")))
          (opt "\n"))
        ,(fn [& xs] xs)))

# Part 1: Seeds are simple values
(def almanac-peg 
  ~(cmt (sequence ,seeds-peg "\n" (some ,map-peg))
        ,create-almanac))

# Part 2: Seeds are actually ranges
(def ranged-almanac-peg
  ~(cmt (sequence ,seed-ranges-peg "\n" (some ,map-peg))
        ,create-almanac))

(defn parse-input-part1 [input] 
  (let [@[almanac] (peg/match almanac-peg input)]
    almanac))

(defn parse-input-part2 [input] 
  (let [@[almanac] (peg/match ranged-almanac-peg input)]
    almanac))
