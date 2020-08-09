module Machine
    ( getValue
    , Coin (..)
    , Product (..)
    , acceptCoins
    , selectProduct
    ) where


data Coin = Coin { weight :: Float, diameter :: Float, thickness :: Float, reeds :: Integer } deriving (Show, Eq)

data Product = Cola | Chips | Candy deriving (Show, Eq)

getValue :: Coin -> Maybe Integer
getValue (Coin 5.000  21.21 1.95 0)     = Just 5   --Nickel
getValue (Coin 2.268  17.91 1.35 118)   = Just 10  --Dime
getValue (Coin 5.670  24.26 1.75 119)   = Just 25  -- Quarter
getValue _                              = Nothing
--getValue (Coin 2.500  19.05 1.52 0)     = Just 1   --Penny
--getValue (Coin 11.340 30.61 2.15 150)   = Just 50  --Half Dollar
--getValue (Coin 8.1    26.49 2.00 0)     = Just 100 --Dollar

acceptCoins :: [Coin] -> (Integer, [Coin])
acceptCoins = foldl acceptCoin (0, [])

acceptCoin :: (Integer, [Coin]) -> Coin -> (Integer, [Coin])
acceptCoin (total, rejected) coin =
  let maybeVal = getValue coin
  in case maybeVal of
    Just val -> (total + val, rejected)
    Nothing  -> (total, coin:rejected)


selectProduct :: Integer -> Product -> (Maybe Product, Integer)
selectProduct total product
  | total < cost  = (Nothing, total)
  | otherwise     = (Just product, total - cost)
  where cost = getCost product

getCost :: Product -> Integer
getCost Cola  = 100
getCost Chips = 50
getCost Candy = 65
