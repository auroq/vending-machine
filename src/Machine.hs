module Machine
    ( getValue
    ) where

getValue :: Float -> Float -> Float -> Integer -> Maybe Integer
getValue 5.000  21.21    1.95      0     = Just 5   --Nickel
getValue 2.268  17.91    1.35      118   = Just 10  --Dime
getValue 5.670  24.26    1.75      119   = Just 25  -- Quarter
getValue weight diameter thickness reeds = Nothing
--getValue 2.500  19.05    1.52      0     = Just 1   --Penny
--getValue 11.340 30.61    2.15      150   = Just 50  --Half Dollar
--getValue 8.1    26.49    2.00      0     = Just 100 --Dollar
