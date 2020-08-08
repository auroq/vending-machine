module MachineSpec where

import Machine
import Test.Hspec
import Test.Validity

nickel = Coin 5.0 21.21 1.95 0
dime = Coin 2.268 17.91 1.35 118
quarter = Coin 5.670 24.26 1.75 119
penny = Coin 2.500 19.05 1.52 0
halfDollar = Coin 11.340 30.61 2.15 150
dollar = Coin 8.1 26.49 2.00 0
fraud = Coin 5.0 20.26 1.75 119

spec :: Spec
spec = do
  describe "when identifying a coin" $ do
    identificationTest "nickel" (Just 5) nickel
    identificationTest "dime" (Just 10) dime
    identificationTest "quarter" (Just 25) quarter
    identificationTest "penny" Nothing penny
    identificationTest "half dollar" Nothing halfDollar
    identificationTest "dollar" Nothing dollar
    identificationTest "fraud" Nothing fraud
  describe "when accepting coins" $ do
    context "and one valid coin" $ do
      let (total, returned) = acceptCoins [nickel]
      let expectedTotal = 5
      it "should total correctly" $
        total `shouldBe` expectedTotal
      it "should return no coins" $
        returned `shouldBe` []
    context "and one invalid coin" $ do
      let (total, returned) = acceptCoins [fraud]
      let expectedTotal = 0
      it "should total correctly" $
        total `shouldBe` expectedTotal
      it "should return no the coin" $
        returned `shouldBe` [fraud]
    context "and many valid coins" $ do
      let (total, returned) = acceptCoins [nickel, dime, quarter, quarter]
      let expectedTotal = 65
      it "should total correctly" $
        total `shouldBe` expectedTotal
      it "should return no coins" $
        returned `shouldBe` []
    context "and many invalid coins" $ do
      let (total, returned) = acceptCoins [fraud, fraud, dollar, halfDollar, penny, fraud]
      let expectedTotal = 0
      it "should total correctly" $
        total `shouldBe` expectedTotal
      it "should return no coins" $
        returned `shouldBe` [fraud, penny, halfDollar, dollar, fraud, fraud]
    context "and many mixed coins" $ do
      let (total, returned) = acceptCoins [penny, nickel, dime, quarter, halfDollar, dollar, fraud]
      let expectedTotal = 40
      it "should total correctly" $
        total `shouldBe` expectedTotal
      it "should return no invalid coins" $
        returned `shouldBe` [fraud, dollar, halfDollar, penny]


identificationTest :: String -> Maybe Integer -> Coin -> SpecWith ()
identificationTest coinName expected coin =
  context ("and the coin is a " ++ coinName) $
    it ("should return value of " ++ show expected) $ do
      let actual = getValue coin
      actual `shouldBe` expected
