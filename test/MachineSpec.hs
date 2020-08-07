module MachineSpec where

import Machine
import Test.Hspec
import Test.Validity



spec :: Spec
spec = do
  describe "when identifying a coin" $ do
    context "and the coin is a nickel" $ do
      it "should return value of 5" $ do
        let expected = 5
        let actual = getValue 5.0 21.21 1.95 0
        actual `shouldBe` expected