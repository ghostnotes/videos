module VideoSharingServices
  class Youtube
    @@technology_channels = Array[
      'xdadevelopers',
      'jon4lakers',
      'SoldierKnowsBest',
      'revision3',
      'TheTechFeed',
      'geekbeattv',
      'engadget',
      'marquesbrownlee',
      'phonedog',
      'Rev3Games',
    ]

    @@english_channels = Array[
      'cyoshida1231',
    ]

    @@business_channels = Array[
      'takaponjp',
    ]

    @@three_dimensions_channels = Array[
      'KanabanGraphics',
      'modo3d',
      'OfficialLightWave3D',
    ]

    CHANNELS = {
      Videos::Category::TECHNOLOGY => @@technology_channels,
      Videos::Category::ENGLISH => @@english_channels,
      Videos::Category::BUSINESS => @@business_channels,
      Videos::Category::THREE_DIMENSIONS => @@three_dimensions_channels,
    }
  end

  class Vimeo
  end
end