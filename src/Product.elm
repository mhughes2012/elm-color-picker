module Product exposing (Product, initialColors, initialImages)

import ColorOption exposing (ColorOption)


type alias Product =
    { title : String
    , price : Float
    , colors : List ColorOption
    , images : List String
    , description : String
    }


initialColors : List ColorOption
initialColors =
    [ { name = "Royal Blue"
      , hexCode = "#4169E1"
      }
    , { name = "Forest Green"
      , hexCode = "#228B22"
      }
    , { name = "Ruby Red"
      , hexCode = "#E0115F"
      }
    ]


initialImages : List String
initialImages =
    [ "https://placehold.co/300x300/4169E1/4169E1" -- Royal Blue
    , "https://placehold.co/300x300/228B22/228B22" -- Forest Green
    , "https://placehold.co/300x300/E0115F/E0115F" -- Ruby Red
    ]
