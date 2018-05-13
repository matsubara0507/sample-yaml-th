{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PolyKinds         #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeOperators     #-}

module Sample.Extensible.Config where

import           RIO
import           RIO.Directory   (doesFileExist)

import           Data.Extensible
import qualified Data.Yaml       as Y
import qualified Data.Yaml.TH    as YTH

type Config = Record
   '[ "columns" >: Int
    , "language-extensions" >: [String]
    ]

defaultConfig :: Config
defaultConfig = $$(YTH.decodeFile "./template/.extensible-config.yaml")

readConfig :: FilePath -> IO Config
readConfig = readConfigWith defaultConfig

readConfigWith :: Config -> FilePath -> IO Config
readConfigWith def path = do
  file <- readFileBinaryWith "" path
  if Y.decodeEither file == Right Y.Null then
    pure def
  else do
    config <- either (error . show) pure $ Y.decodeEither' file
    pure $ fromNullable def config

readFileBinaryWith :: ByteString -> FilePath -> IO ByteString
readFileBinaryWith def path =
  doesFileExist path >>= bool (pure def) (readFileBinary path)

fromNullable :: RecordOf h xs -> Nullable (Field h) :* xs -> RecordOf h xs
fromNullable def =
  hmapWithIndex $ \m x -> fromMaybe (hlookup m def) (getNullable x)
