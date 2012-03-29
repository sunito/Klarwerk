require 'test_helper'

class QuellenControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:quellen)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_quelle
    assert_difference('Quelle.count') do
      post :create, :quelle => { }
    end

    assert_redirected_to quelle_path(assigns(:quelle))
  end

  def test_should_show_quelle
    get :show, :id => quellen(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => quellen(:one).id
    assert_response :success
  end

  def test_should_update_quelle
    put :update, :id => quellen(:one).id, :quelle => { }
    assert_redirected_to quelle_path(assigns(:quelle))
  end

  def test_should_destroy_quelle
    assert_difference('Quelle.count', -1) do
      delete :destroy, :id => quellen(:one).id
    end

    assert_redirected_to quellen_path
  end
end
