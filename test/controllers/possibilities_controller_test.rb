require 'test_helper'

class PossibilitiesControllerTest < ActionController::TestCase
  setup do
    @possibility = possibilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:possibilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create possibility" do
    assert_difference('Possibility.count') do
      post :create, possibility: { name: @possibility.name, topic_id: @possibility.topic_id, user_id: @possibility.user_id }
    end

    assert_redirected_to possibility_path(assigns(:possibility))
  end

  test "should show possibility" do
    get :show, id: @possibility
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @possibility
    assert_response :success
  end

  test "should update possibility" do
    patch :update, id: @possibility, possibility: { name: @possibility.name, topic_id: @possibility.topic_id, user_id: @possibility.user_id }
    assert_redirected_to possibility_path(assigns(:possibility))
  end

  test "should destroy possibility" do
    assert_difference('Possibility.count', -1) do
      delete :destroy, id: @possibility
    end

    assert_redirected_to possibilities_path
  end
end
