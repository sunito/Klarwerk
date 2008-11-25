require 'test_helper'

class ZeitenControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:zeiten)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_zeit
    assert_difference('Zeit.count') do
      post :create, :zeit => { }
    end

    assert_redirected_to zeit_path(assigns(:zeit))
  end

  def test_should_show_zeit
    get :show, :id => zeiten(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => zeiten(:one).id
    assert_response :success
  end

  def test_should_update_zeit
    put :update, :id => zeiten(:one).id, :zeit => { }
    assert_redirected_to zeit_path(assigns(:zeit))
  end

  def test_should_destroy_zeit
    assert_difference('Zeit.count', -1) do
      delete :destroy, :id => zeiten(:one).id
    end

    assert_redirected_to zeiten_path
  end
end
