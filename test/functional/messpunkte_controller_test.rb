require 'test_helper'

class MesspunkteControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:messpunkte)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_messpunkt
    assert_difference('Messpunkt.count') do
      post :create, :messpunkt => { }
    end

    assert_redirected_to messpunkte_path #(assigns(:messpunkt))
  end

  def test_should_show_messpunkt
    get :show, :id => messpunkte(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => messpunkte(:one).id
    assert_response :success
  end

  def test_should_update_messpunkt
    put :update, :id => messpunkte(:one).id, :messpunkt => { }
    assert_redirected_to messpunkt_path(assigns(:messpunkt))
  end

  def test_should_destroy_messpunkt
    assert_difference('Messpunkt.count', -1) do
      delete :destroy, :id => messpunkte(:one).id
    end

    assert_redirected_to messpunkte_path
  end
end
