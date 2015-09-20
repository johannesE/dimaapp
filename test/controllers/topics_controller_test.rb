require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @topic = topics(:topicone)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic" do
    login_user
    assert_difference('Topic.count') do
      post :create, topic: { question: @topic.question, user_id: @topic.user_id }, user_id: users(:user_one).id
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should show topic" do
    get :show, id: @topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic
    assert_response :success
  end

  test "should update topic" do
    login_user
    patch :update, id: @topic, topic: { question: @topic.question, user_id: @topic.user_id }
    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should destroy topic" do
    login_user
    assert_difference('Topic.count', -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to topics_path
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
