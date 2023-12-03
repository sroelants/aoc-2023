(defn- structure-match [line start value end] 
  ``Cast the captured information into a handy lookup table of the form
    @{ :value <val> :x <col> :y <line> :width <w> }
  ``
  @{ :value value :width (- end start) :x start :y line })

(defn- structured-peg [patt] 
  ``Take a (capture!) pattern `patt` and return a peg that captures additional 
    metadata on every match, in the form @{ :value <val> :x <col> :y <line> 
    :width <w> }
  ``
  ~(cmt (sequence (line) (column) ,patt (column)) ,structure-match))

# A PEG that parses numbers into structured objects
(def number-peg (structured-peg ~(number :d+)))

# A PEG that parses symbols into structured objects
(def symbol-peg 
  (structured-peg 
    ~(capture
       (choice "*" "#" "+" "$" "=" "&" "@" "/" "-" "%"))))

(defn parse-numbers [input]
  (peg/match ~(some (choice :D ,number-peg)) input))

(defn parse-symbols [input]
  (peg/match ~(some (choice "." "\n" :d+ ,symbol-peg)) input))

