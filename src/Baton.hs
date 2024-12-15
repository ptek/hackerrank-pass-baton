{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Baton (passBaton) where

import Protolude

data Direction = Forward | Back | PassingBackToBeginning deriving (Eq, Ord, Show)

passBaton :: Int -> Int -> (Int, Int)
passBaton friends _ | friends <=0 = (0,0)
passBaton _ time | time <=0 = (0,0)
passBaton 1 _ = (1,1)
passBaton friends time = (starting_point, ending_point)
  where
  position_in_sequence :: Int = time `mod` (friends + friends - 2)
  -- time is always positive, because the case of 0 is pattern matched against
  -- in the previous checks. Therefore, when position_in_sequence is 0, it means
  -- that we are passing back to the beginning
  which_direction_start :: Direction =
    if position_in_sequence == 0 then PassingBackToBeginning
    else if position_in_sequence < friends then Forward
    else Back
  which_direction_end :: Direction = if position_in_sequence+1 < friends then Forward else Back
  starting_point
    | which_direction_start == PassingBackToBeginning = 2
    | which_direction_start == Forward = position_in_sequence
    | otherwise                        = friends * 2 - position_in_sequence
  ending_point
    | which_direction_end == Forward = position_in_sequence+1
    | otherwise                      = friends * 2 - position_in_sequence -1
