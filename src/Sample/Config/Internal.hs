{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE DeriveLift      #-}
{-# LANGUAGE TemplateHaskell #-}

module Sample.Config.Internal where

import qualified Data.Yaml.TH             as Y
import           GHC.Generics
import           Language.Haskell.TH.Lift

data Config = Config
  { columns            :: Int
  , languageExtensions :: [String]
  } deriving (Show, Eq, Generic, Lift)

instance Y.FromJSON Config
