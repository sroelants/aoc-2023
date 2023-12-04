# Janet doesn't have built-in sets, so we're mocking a _very_ space-inefficient
# (but fairly time-efficient!) set by pre-allocating a 100 element array of
# bools for every number.
(defn create-set [& xs] 
  (let [number-set (array/new-filled 100 false)]
    (loop [x :in xs]
      (put number-set x true))
    number-set))

# Check whether a set contains a particular number
(defn contains? [xs x] (get xs x))
