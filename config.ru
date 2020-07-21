require './config/environment'

use Rack::MethodOverride

use SpellbookController
use MonsterController
use UserController
run ApplicationController
