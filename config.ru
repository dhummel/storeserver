#!/usr/bin/env ruby
require 'rhoconnect/application/init'

# secret is generated along with the app
Rhoconnect::Server.set     :secret,      'e11c05ba94341d43bb0438cb7bc21a9beb76903e1708eaec5960e843dc6827043c99c0adfc88f8ab4e0078555dd9e95533e644660513ed7e61dc30ac2a8f4825'

# !!! Add your custom initializers and overrides here !!!
# For example, uncomment the following line to enable Stats
#Rhoconnect::Server.enable  :stats
# uncomment the following line to disable Resque Front-end console
#Rhoconnect.disable_resque_console = true
# uncomment the following line to disable Rhoconnect Front-end console
#Rhoconnect.disable_rc_console = true

# run RhoConnect Application
run Rhoconnect.app
