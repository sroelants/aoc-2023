(use ../day-1/part1)
(use ../day-1/part2)

(def test-input ``1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet``)

(def test-input-2 ``two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen``)

(def lines (string/split test-input "\n"))

(assert (deep= (parse-ints "1abc2") @[1 2]))
(assert (deep= (parse-ints "pqr3stu8vwx") @[3 8]))
(assert (deep= (parse-ints "a1b2c3d4e5f") @[1 2 3 4 5]))
(assert (deep= (parse-ints "treb7uchet") @[7]))
(assert (deep= (parse-ints "trebuchet") @[]))

(assert (= (combine (parse-ints "1abc2")) 12))
(assert (= (combine (parse-ints "pqr3stu8vwx")) 38))

(assert (= (part1 test-input) 142))
(assert (= (part2 test-input-2) 281))
(assert (deep= (substrings "abc") @["abc" "bc" "c"]))
(assert (deep= (parse-digits "oneb2c") @[1 2]))
