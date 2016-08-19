require 'test_helper'

class MemosInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "memo interface" do
    log_in_as(@user)
    get root_path
    # 無効な送信
    assert_no_difference 'Memo.count' do
      post memos_path, memo: { content: "" }
    end
    #assert_select 'div#error_explanation'
    # 有効な送信
    content = "This memo really ties the room together"
    assert_difference 'Memo.count', 1 do
      post memos_path, memo: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_memo = @user.memos.first
    assert_difference 'Memo.count', -1 do
      delete memo_path(first_memo)
    end
  end
end
