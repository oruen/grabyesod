import Text.XML.HXT.Core
import Text.HandsomeSoup
import System.Process
import Data.Char
import Data.String.Utils
import Data.List (sort, group)
import Control.Monad
import Text.Regex

getPage :: [String] -> String -> IO [String]
getPage acc url = do
  putStrLn $ "Getting " ++ url
  doc <- fromUrl url
  content <- runX $ doc >>> css ".why" >>> removeAllWhiteSpace //> getText >>> arr (words . strip . map toUpper) >>. concat
  return $ content ++ acc

main = do
  doc <- fromUrl "http://www.yesodweb.com/book"
  links <- runX $ doc >>> css ".why ul a" ! "href"
  list <- foldM getPage [] links
  putStr $ show $ (map (head &&& length) . group . sort) list
  --(doc >>> css ".why" >>> removeAllWhiteSpace //> getText) >>> arr (words . strip . (replace ":," "") . map toUpper) >>. concat >>. (map (head &&& length) . group . sort)

