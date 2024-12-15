{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Baton (passBaton) where

import Protolude


data Direction = Forward | Back | PassingBackToBeginning deriving (Eq, Ord, Show)


passBaton :: Int -> Int -> (Int, Int)
passBaton friends time | friends <= 0 || time <= 0 = (0, 0)
passBaton 1 _ = (1, 1)
passBaton friends time = (passer, receiver)
 where
  -- the sequence is the whole set of passes of baton first forward, then backwards
  -- and then back to the first friend
  position_in_sequence :: Int = time `mod` (friends + friends - 2)

  -- time is always positive, because the case of 0 is pattern matched against
  -- in the previous checks. Therefore, when position_in_sequence is 0, it means
  -- that we are at the end of the sequence and the batton is being passed back
  -- to the first friend
  which_direction_passer :: Direction =
    if position_in_sequence == 0
      then PassingBackToBeginning
      else
        if position_in_sequence < friends
          then Forward
          else Back

  -- The direction of the receiver turns backwards when the baton reaches the
  -- middle of the sequence. As the sequence is forwards, then backwards, the
  -- middle will be when the baton passes all the friends
  which_direction_receiver :: Direction =
    if position_in_sequence == 0
      then PassingBackToBeginning
      else
        if position_in_sequence + 1 < friends
          then Forward
          else Back

  passer = case which_direction_passer of
    PassingBackToBeginning -> 2
    Forward -> position_in_sequence
    Back -> friends * 2 - position_in_sequence

  receiver = case which_direction_receiver of
    PassingBackToBeginning -> 1
    Forward -> position_in_sequence + 1
    _ -> friends * 2 - position_in_sequence - 1
