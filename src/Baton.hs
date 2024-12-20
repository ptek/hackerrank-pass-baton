{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Baton (passBaton) where

import Protolude

data Direction = Forward | Back | PassingBackToBeginning deriving (Eq, Ord, Show)

passBaton :: Int -> Int -> Maybe (Int, Int)
passBaton friends time | friends <= 0 || time <= 0 = Nothing
passBaton 1 _ = Just (1, 1)
passBaton friends time = Just (passer, receiver)
  where
    -- the sequence is the whole set of passes of baton first forward, then backwards
    -- and then back to the first friend. For example with 3 friends it would be
    -- 1 -> 2 -> 3 -> 2 _and the sequence starts over_ -> 1 -> 2 -> 3 -> 2 ...
    position_in_sequence :: Int = time `mod` (friends + friends - 2)

    -- time is always positive, because the case of 0 is pattern matched against
    -- in the previous checks. Therefore, when position_in_sequence is 0, it means
    -- that we are at the end of the sequence and the baton is being passed back
    -- to the first friend. We still check for time not to be equal 0 here so that
    -- the function is complete in its definition, and does not introduce bugs
    -- sometime in the future if we stop handling the case of time being 0 in
    -- the other part of the code any more
    which_direction :: Direction
      | position_in_sequence == 0 && time /= 0 = PassingBackToBeginning
      | position_in_sequence < friends = Forward
      | otherwise = Back

    passer = case which_direction of
      PassingBackToBeginning -> 2
      Forward -> position_in_sequence
      Back -> friends * 2 - position_in_sequence

    receiver = case which_direction of
      PassingBackToBeginning -> 1
      Forward -> position_in_sequence + 1
      Back -> friends * 2 - position_in_sequence - 1
