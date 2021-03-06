#
# Author:: Noah Kantrowitz <noah@coderanger.net>
#
# Copyright 2013-2014, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef
  # Using the actual module
  class Resource::IncludeRecipeTestOne < Resource
    def initialize(*args)
      super
      @resource_name = :include_recipe_test_one
      @action = :run
    end

    def included_recipe(arg=nil)
      set_or_return(:included_recipe, arg, {})
    end
  end

  class Provider::IncludeRecipeTestOne < Provider
    include Poise::Provider::IncludeRecipe

    def load_current_resource
    end

    def action_run
      include_recipe new_resource.included_recipe
    end
  end

  # Using the Poise::Provider helper
  class Resource::IncludeRecipeTestTwo < Resource
    def initialize(*args)
      super
      @resource_name = :include_recipe_test_two
      @action = :run
    end

    def included_recipe(arg=nil)
      set_or_return(:included_recipe, arg, {})
    end
  end

  class Provider::IncludeRecipeTestTwo < Provider
    include Poise::Provider

    def load_current_resource
    end

    def action_run
      include_recipe new_resource.included_recipe
    end
  end

  # Using the Poise helper
  class Resource::IncludeRecipeTestThree < Resource
    def initialize(*args)
      super
      @resource_name = :include_recipe_test_three
      @action = :run
    end

    def included_recipe(arg=nil)
      set_or_return(:included_recipe, arg, {})
    end
  end

  class Provider::IncludeRecipeTestThree < Provider
    include Poise

    def load_current_resource
    end

    def action_run
      include_recipe new_resource.included_recipe
    end
  end
end
