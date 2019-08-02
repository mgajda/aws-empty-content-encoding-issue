{-# LANGUAGE OverloadedStrings #-}
module Main where

import Network.AWS
import Network.AWS.S3
import Network.AWS.S3.PutObject
import Control.Lens
import Control.Monad.IO.Class
import qualified Data.ByteString as BSL

bucketName = "test.migamake.com"

main = do
  env  <- newEnv Discover
  runResourceT $ runAWS env $
    within Frankfurt $ do
      --content <- liftIO $ BSL.readFile "public/index.html" -- this works
      content <- chunkedFile 8192 "public/index.html" -- this results in empty metadata
      result  <- send $ set poContentType     (Just "text/html")
               -- $ set poContentEncoding (Just "identity") -- this breaks signing
               $ putObject bucketName (ObjectKey "index.html") (toBody content)
      liftIO   $ print result
