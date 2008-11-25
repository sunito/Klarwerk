require 'test_helper'

class EinheitenControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:einheiten)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_einheit
    assert_difference('Einheit.count') do
      post :create, :einheit => { }
    end

    assert_redirected_to einheit_path(assigns(:einheit))
  end

  def test_should_show_einheit
    get :show, :id => einheiten(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => einheiten(:one).id
    assert_response :success
  end

  def test_should_update_einheit
    put :update, :id => einheiten(:one).id, :einheit => { }
    assert_redirected_to einheit_path(assigns(:einheit))
  end

  def test_should_destroy_einheit
    assert_difference('Einheit.count', -1) do
      delete :destroy, :id => einheiten(:one).id
    end

    assert_redirected_to einheiten_path
  end
end
