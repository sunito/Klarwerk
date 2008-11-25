require 'test_helper'

class DiagrammeControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:diagramme)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_diagramm
    assert_difference('Diagramm.count') do
      post :create, :diagramm => { }
    end

    assert_redirected_to diagramm_path(assigns(:diagramm))
  end

  def test_should_show_diagramm
    get :show, :id => diagramme(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => diagramme(:one).id
    assert_response :success
  end

  def test_should_update_diagramm
    put :update, :id => diagramme(:one).id, :diagramm => { }
    assert_redirected_to diagramm_path(assigns(:diagramm))
  end

  def test_should_destroy_diagramm
    assert_difference('Diagramm.count', -1) do
      delete :destroy, :id => diagramme(:one).id
    end

    assert_redirected_to diagramme_path
  end
end
