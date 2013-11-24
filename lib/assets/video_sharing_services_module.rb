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
      '3dsMaxHowTos',
    ]

    CHANNELS = {
        'Technology' => @@technology_channels,
        'English' => @@english_channels,
        'Business' => @@business_channels,
        'ThreeDimensions' => @@three_dimensions_channels,
    }

    def self.get_feed_entries
    end
  end

  class Vimeo
  end
end