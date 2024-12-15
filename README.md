# Hackerrank passBaton

This is a try to implement the passBaton Hackerrank function

From what I can recollect, the challenge is that there are n friends standing
in a line, each numbered from 1 through n inclusive. The first one, friend 1,
holds a baton. Each second, the baton is passed to the next friend in line.
Once it reaches the end of the line, the direction of passing is reversed and
passing continues. Determine who will pass and who will receive the baton at a
given time.

*Example*
friends = 4
time = 5

Friends are therefore numbered 1 through 4. Friend 1 holds the baton at time 0.
At time 1, it is passed to friend 2. Over 5 seconds, the baton is passed as
1->2->3->4->3->2. The friend passing the baton at time 5 is friend 3. The
friend receiving the baton is friend 2. Return (3, 2).

## Dev dependencies

haskell stack via https://www.haskell.org/ghcup/ or https://stackage.org

## Verify result

run `stack test`
