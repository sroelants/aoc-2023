# Problem
Given a list of cards, each with a list of winning numbers, and a list of 
revealed numbers, separated by a `|` . Essentially, count how many matches for
each card, and score them.

# Parsing the input
I suppose we'd want to convert the input into something more structured, like
```
"Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
=> { :card 1 :winning @[...] :scratched @[...] }
```

In principle, there's no need to store the card number, but I have a sneaking
suspicion that we might need them later on, so might as well parse them right 
away instead of discarding them. (We need to match on them anyway.)

# Matching
I'm sure there's more efficient ways, but the obvious brute-force way of
checking for matches for a card is simply looping over the scratched numbers,
and for each of them check whether or not they appear in the winning set.
Ideally, we'd want to chuck all of these into sets, rather than arrays.
Or, the poor man's set: just pre-allocate a 100 element array of booleans and
use those as masks. Heck, if Janet had good bit operations, I would probably 
use bitmasks. (E.g., if we have access to 128bit integers, we could simply xor
together a bunch of bitmasks, and checking would become trivial). But I don't
think we'll get access to 128bit integers, or popcounts, for that matter.
Shame...

Hmm, we do have access to u64's though, right?
So, could we have a set of numbers be represented as 2 u64s?

In that case, we could have an abstract data type that hides that
implementation, and we can just add numbers to a set, and check whether a number
is in the set. I like it.

The other, slightly lamer option, is to use a hashtable with boolean values
to signify whether or not an element is 

I think the lazy way is to use the pre-allocated arrays. It's only 400 arrays,
it'll be fine.
