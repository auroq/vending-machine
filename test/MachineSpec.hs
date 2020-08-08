module MachineSpec where

import Machine
import Test.Hspec
import Test.Validity


spec :: Spec
spec = do
  describe "when identifying a coin" $ do
      identificationTest "nickel" (Just 5) 5.0 21.21 1.95 0
      identificationTest "dime" (Just 10) 2.268 17.91 1.35 118
      identificationTest "quarter" (Just 25) 5.670 24.26 1.75 119
      identificationTest "penny" Nothing 2.500 19.05 1.52 0
      identificationTest "half dollar" Nothing 11.340 30.61 2.15 150
      identificationTest "dollar" Nothing 8.1 26.49 2.00 0
      identificationTest "fraud" Nothing 5.0 20.26 1.75 119


identificationTest coin expected weight diameter thickness reeds = do
  context ("and the coin is a " ++ coin) $ do
    it ("should return value of " ++ show expected) $ do
      let actual = getValue weight diameter thickness reeds
      actual `shouldBe` expected
