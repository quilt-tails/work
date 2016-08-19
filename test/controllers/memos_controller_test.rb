require 'test_helper'

class MemosControllerTest < ActionController::TestCase

  def setup
    @memo = memos(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Memo.count' do
      post :create, memo: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Memo.count' do
      delete :destroy, id: @memo
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong memo" do
    log_in_as(users(:michael))
    memo = memos(:ants)
    assert_no_difference 'Memo.count' do
      delete :destroy, id: memo
    end
    assert_redirected_to root_url
  end
end
