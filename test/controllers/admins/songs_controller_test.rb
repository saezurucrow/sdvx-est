require "test_helper"

class Admins::SongsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admins_songs_new_url
    assert_response :success
  end

  test "should get edit" do
    get admins_songs_edit_url
    assert_response :success
  end

  test "should get update" do
    get admins_songs_update_url
    assert_response :success
  end

  test "should get delete" do
    get admins_songs_delete_url
    assert_response :success
  end
end
