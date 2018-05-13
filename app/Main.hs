{-# LANGUAGE NoImplicitPrelude #-}

module Main where

import           RIO

import           Sample.Extensible.Config
import           System.Environment       (getArgs)

main :: IO ()
main = do
  path <- fromMaybe "" . listToMaybe <$> getArgs
  hPutBuilder stdout =<< encodeUtf8Builder . tshow <$> readConfig path
