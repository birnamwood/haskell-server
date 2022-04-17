-- 型の型を実現する仕組み
{-# LANGUAGE DataKinds #-}
-- 型レベル計算を有効に
{-# LANGUAGE TypeOperators #-}

module Router
    ( runServant
    ) where

import    Network.Wai.Handler.Warp (run)
import    Servant
import    Control.Monad.IO.Class   (liftIO)

runServant :: IO ()
runServant = do
    let port = 8000
    putStrLn "runServer"
    run port app
    putStrLn "stopServer"

type API = "test" :> Get '[JSON] Int
        :<|> "test2" :> Get '[JSON] String

server :: Server API
server = testHandler
        :<|> test2Handler

api :: Proxy API
api = Proxy

app :: Application
app = serve api server

testHandler :: Handler Int
testHandler = do
    return 1

test2Handler :: Handler String
test2Handler = do
    return "test2"