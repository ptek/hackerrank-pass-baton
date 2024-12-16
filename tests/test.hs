import Baton (passBaton)
import Test.Tasty
import Test.Tasty.HUnit

main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [unitTests]

unitTests =
  testGroup
    "Baton passing"
    [ testCase "0 friends 0 times" $ passBaton 0 0 @?= Nothing,
      testCase "0 friends n time" $ passBaton 0 100 @?= Nothing,
      testCase "n friends 0 time" $ passBaton 100 0 @?= Nothing,
      testCase "negative friends" $ passBaton (-1) 100 @?= Nothing,
      testCase "negative time" $ passBaton 100 (-1) @?= Nothing,
      testCase "1 friend, n times" $ passBaton 1 100 @?= Just (1, 1), -- 1>1>1..1->-1
      testCase "2 friends 1 time" $ passBaton 2 1 @?= Just (1, 2), -- 1->-2...
      testCase "3 friends 1 time" $ passBaton 3 1 @?= Just (1, 2), -- 1->-2>3...
      testCase "3 friends 2 times" $ passBaton 3 2 @?= Just (2, 3), -- 1>2->-3...
      testCase "3 friends 3 times" $ passBaton 3 3 @?= Just (3, 2), -- 1>2>3->-2...
      testCase "3 friends 4 times" $ passBaton 3 4 @?= Just (2, 1), -- 1>2>3>2->-1...
      testCase "3 friends 5 times" $ passBaton 3 5 @?= Just (1, 2), -- 1>2>3>2>1->-2...
      testCase "3 friends 7 times" $ passBaton 3 7 @?= Just (3, 2), -- 1>2>3>2>1>2>3->-2...
      testCase "3 friends 12 times" $ passBaton 3 12 @?= Just (2, 1), -- 1>2>3>2>1>2>3>2>1>2>3>2->-1...
      testCase "22 friends 42 times" $ passBaton 22 42 @?= Just (2, 1)
    ]
