{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Sample.Extensible.Config where

import           Data.Extensible
import qualified Data.Yaml.TH    as Y

type Config = Record
   '[ "columns" >: Int
    , "language-extensions" >: [String]
    ]

defaultConfig :: Config
defaultConfig = $$(Y.decodeFile "./template/.extensible-config.yaml")
