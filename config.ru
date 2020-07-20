require './config/environment'

use Rack::MethodOverride

use SpellbookController
use UserController
run ApplicationController
