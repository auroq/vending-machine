module MachineSpec where

import Machine
import Test.Hspec
import Test.Validity


spec :: Spec
spec = do
  describe "when identifying a coin" $ do
    context "and the coin is a nickel" $ do
      identificationTest 5 5.0 21.21 1.95 0
      identificationTest 10 2.268 17.91 1.35 0


identificationTest expected weight diameter thickness reeds = do
  it ("should return value of " ++ show expected) $ do
    let actual = getValue weight diameter thickness reeds
    actual `shouldBe` expected
