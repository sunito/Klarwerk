require 'test_helper'

class DiaquenControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:diaquen)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_diaque
    assert_difference('Diaque.count') do
      post :create, :diaque => { }
    end

    assert_redirected_to diaque_path(assigns(:diaque))
  end

  def test_should_show_diaque
    get :show, :id => diaquen(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => diaquen(:one).id
    assert_response :success
  end

  def test_should_update_diaque
    put :update, :id => diaquen(:one).id, :diaque => { }
    assert_redirected_to diaque_path(assigns(:diaque))
  end

  def test_should_destroy_diaque
    assert_difference('Diaque.count', -1) do
      delete :destroy, :id => diaquen(:one).id
    end

    assert_redirected_to diaquen_path
  end
end
