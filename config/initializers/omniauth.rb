Rails.application.config.middleware.use OmniAuth::Builder do
   # ALWAYS RESTART YOUR SERVER IF YOU MAKE CHANGES TO THESE SETTINGS!
   
   # you need a store for OpenID; (if you deploy on heroku you need Filesystem.new('./tmp') instead of Filesystem.new('/tmp'))
   require 'openid/store/filesystem'

   # providers with id/secret, you need to sign up for their services (see below) and enter the parameters here
   provider :facebook, '271203636242426', '905e634d11cd90585c1d030a5fc82693'
   provider :twitter, 'DDDzeF7wRvnXSfVDaCX7gg', 'O7Qg2p5WTJlwhgPfr6tm2rVMDNbfqkjDawlRJ2R8zYI'
   provider :github, '082fa7897bd2bc306ee1', '511993d9b72a3162753caea73be333ab41236fe0'
   
   # generic openid
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'
   
   # dedicated openid
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
   # provider :google_apps, OpenID::Store::Filesystem.new('./tmp'), :name => 'google_apps'
   # /auth/google_apps; you can bypass the prompt for the domain with /auth/google_apps?domain=somedomain.com
   
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'yahoo', :identifier => 'yahoo.com' 
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'aol', :identifier => 'openid.aol.com'
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'myopenid', :identifier => 'myopenid.com'
   
   # Sign-up urls for Facebook, Twitter, and Github
   # https://developers.facebook.com/setup
   # https://github.com/account/applications/new
   # https://developer.twitter.com/apps/new
end
