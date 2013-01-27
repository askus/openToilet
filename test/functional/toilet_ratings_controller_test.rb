require 'test_helper'

class ToiletRatingsControllerTest < ActionController::TestCase
  setup do
    @toilet_rating = toilet_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:toilet_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create toilet_rating" do
    assert_difference('ToiletRating.count') do
      post :create, :toilet_rating => { :cleanness => @toilet_rating.cleanness, :comfort => @toilet_rating.comfort, :comment => @toilet_rating.comment, :has_hook => @toilet_rating.has_hook, :has_tissue => @toilet_rating.has_tissue, :privacy => @toilet_rating.privacy, :safety => @toilet_rating.safety, :toilet_id => @toilet_rating.toilet_id }
    end

    assert_redirected_to toilet_rating_path(assigns(:toilet_rating))
  end

  test "should show toilet_rating" do
    get :show, :id => @toilet_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @toilet_rating
    assert_response :success
  end

  test "should update toilet_rating" do
    put :update, :id => @toilet_rating, :toilet_rating => { :cleanness => @toilet_rating.cleanness, :comfort => @toilet_rating.comfort, :comment => @toilet_rating.comment, :has_hook => @toilet_rating.has_hook, :has_tissue => @toilet_rating.has_tissue, :privacy => @toilet_rating.privacy, :safety => @toilet_rating.safety, :toilet_id => @toilet_rating.toilet_id }
    assert_redirected_to toilet_rating_path(assigns(:toilet_rating))
  end

  test "should destroy toilet_rating" do
    assert_difference('ToiletRating.count', -1) do
      delete :destroy, :id => @toilet_rating
    end

    assert_redirected_to toilet_ratings_path
  end
end
