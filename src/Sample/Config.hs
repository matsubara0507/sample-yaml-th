{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE DeriveLift      #-}
{-# LANGUAGE TemplateHaskell #-}

module Sample.Config
  ( module X
  , defaultConfig
  ) where

import qualified Data.Yaml.TH           as Y
import           Sample.Config.Internal as X

defaultConfig :: Config
defaultConfig = $$(Y.decodeFile "./template/.config.yaml")
