name             'zomeki'
maintainer       'Takehara Toshihiro'
maintainer_email 'takehara@ossone.jp'
license          'All rights reserved'
description      'Installs/Configures zomeki'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "yum",              "~> 2.3.0"
depends "timezone-ii",      "~> 0.2.0"
depends "rbenv",            "~> 1.5.0"
#depends "networking_basic", "~> 0.0.7"
#depends "mysql",       "~> 3.0.0"
#depends "database",    "~> 1.3.0"
#depends "vim",         "~> 1.0.0"

