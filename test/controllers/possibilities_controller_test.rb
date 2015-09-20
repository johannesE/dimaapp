require 'test_helper'

class PossibilitiesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @possibility = possibilities(:one)
    @topic = topics(:topicone)
  end

  test "should get index" do
    get :index, :topic_id => topics(:topicone).id
    assert_response :success
    assert_not_nil assigns(:possibilities)
  end

  test "should get new" do
    get :new, :topic_id => topics(:topicone).id
    assert_response :success
  end

  test "should get vote" do
    get :vote, :topic_id => topics(:topicone).id
    assert_response :success
  end

  test "should_do_vote" do


  end

  test "should create possibility" do
    login_user
    assert_difference('Possibility.count') do
      post :create, :topic_id => @possibility.topic_id, possibility: { name: @possibility.name, topic_id: @possibility.topic_id, user_id: @possibility.user_id }
    end
    assert_response :redirect
  end

  test "should show possibility" do
    get :show, {:topic_id => topics(:topicone).id, id: @possibility}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => @possibility.id, topic_id: topics(:topicone).id}
    assert_response :success
  end

  test "should update possibility" do
    login_user
    patch :update, id: @possibility, possibility: { name: @possibility.name, topic_id: @possibility.topic_id, user_id: @possibility.user_id }, :topic_id => topics(:topicone).id
    assert_response :redirect
  end

  test "should destroy possibility" do
    login_user
    assert_difference('Possibility.count', -1) do
      delete :destroy, id: @possibility, :topic_id => topics(:topicone).id
    end

    assert_redirected_to topic_possibilities_path
  end

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = users(:user_one)
    sign_in user
    # user.confirmed_at = Time.now
    # user.confirm!
    # user.save
    user
  end

end
