require 'test_helper'

class ChampionsControllerTest < ActionController::TestCase
  setup do
    @champion = champions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:champions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create champion" do
    assert_difference('Champion.count') do
      post :create, champion: { image: @champion.image, lane: @champion.lane, name: @champion.name }
    end

    assert_redirected_to champion_path(assigns(:champion))
  end

  test "should show champion" do
    get :show, id: @champion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @champion
    assert_response :success
  end

  test "should update champion" do
    put :update, id: @champion, champion: { image: @champion.image, lane: @champion.lane, name: @champion.name }
    assert_redirected_to champion_path(assigns(:champion))
  end

  test "should destroy champion" do
    assert_difference('Champion.count', -1) do
      delete :destroy, id: @champion
    end

    assert_redirected_to champions_path
  end
end
