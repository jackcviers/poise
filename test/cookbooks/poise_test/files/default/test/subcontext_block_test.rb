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

class NotifyingBlockTest < MiniTest::Chef::TestCase
  def test_one_a_in_collection
    assert run_context.resource_collection.find(subcontext_block_test_one: 'a')
  end

  def test_one_a_not_in_collection
    assert_raises(Chef::Exceptions::ResourceNotFound) { run_context.resource_collection.find(ruby_block: 'subcontext_block_test_inner') }
  end

  def test_one_a_not_run
    assert !node.run_state[:subcontext_block_test_inner]
  end

  def test_one_a_context_match
    assert node.run_state[:subcontext_block_test_global_collection]
    assert node.run_state[:subcontext_block_test_collection]
    assert_equal run_context.resource_collection.object_id, node.run_state[:subcontext_block_test_global_collection].object_id
    refute_equal run_context.resource_collection.object_id, node.run_state[:subcontext_block_test_collection].object_id
    assert_equal run_context.resource_collection.object_id, node.run_state[:subcontext_block_test_collection].parent.object_id
  end
end
