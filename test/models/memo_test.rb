require 'test_helper'

class MemoTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @memo = @user.memos.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @memo.valid?
  end

  test "user id should be present" do
    @memo.user_id = nil
    assert_not @memo.valid?
  end

  test "content should be present" do
    @memo.content = " "
    assert_not @memo.valid?
  end

  test "content should be at most 400 characters" do
    @memo.content = "a" * 401
    assert_not @memo.valid?
  end

  test "order should be most recent first" do
    assert_equal memos(:most_recent), Memo.first
  end
end
