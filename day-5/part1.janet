(import "./parse" :as parse)

(defn contains? [rule value]
  "Test whether or not a mapping range contains the provided value"
  (let [src-start (get rule :src)
        len (get rule :len)]
  (and (<= src-start value)
       (< value (+ src-start len)))))

(defn apply-rule [rule value]
  ``Apply a mapping rule to a value.
    This is a no-op if the rule does not apply to the value``
  (if (contains? rule value)
    (let [offset (- value (get rule :src))]
      (+ (get rule :tgt) offset))
    value))

(defn translate [value mapping]
  "Translate a value according to a provided mapping"
  (let [rule (find (fn [rule] (contains? rule value)) mapping)]
    (if (nil? rule)
      value
      (apply-rule rule value))))

(defn apply-all [value mappings]
  "Run a seed value through all the mappingss in sequence"
  (reduce
          (fn [acc mapping] (translate acc mapping))
          value
          mappings))

(defn part1 [input]
  (let [{ :seeds seeds :maps maps }  (parse/parse-input-part1 input)]
    (min-of (map (fn [seed] (apply-all seed maps)) seeds))))

(defn main [& args]
  (let [input (slurp "./input.txt")]
    (print "Part 1:" (part1 input))))
