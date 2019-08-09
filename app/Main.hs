{-# LANGUAGE OverloadedStrings #-}
module Main where

import Network.AWS
import Network.AWS.S3
import Network.AWS.S3.PutObject
import Control.Lens
import Control.Monad.IO.Class
import qualified Data.ByteString as BSL
import           System.IO(stdout)

bucketName = "test.migamake.com"

main = do
  lgr <- newLogger Debug stdout
  env  <- newEnv Discover <&> set envLogger lgr
  runResourceT $ runAWS env $
    within Frankfurt $ do
      --content <- liftIO $ BSL.readFile "public/index.html" -- this works
      content <- chunkedFile 65000 "cryptogame.svg" -- this results in empty metadata
      result  <- send $ set poContentType     (Just "image/svg+xml")
               $ set poContentEncoding (Just "identity") -- this breaks signing
               $ putObject bucketName (ObjectKey "problem2.svg") (toBody content)
      liftIO   $ print result
