import Text.XML.HXT.Core
import Text.HandsomeSoup
import System.Process

main = do
  doc <- fromUrl "http://www.yesodweb.com/book"
  links <- runX $ doc >>> css ".why ul a" >>> getAttrValue "href"
  runCommand $ "wkhtmltopdf -l --title \"Yesod Book\" " ++ (concatMap (\x -> x ++ " ") links) ++ "YesodBook.pdf"
