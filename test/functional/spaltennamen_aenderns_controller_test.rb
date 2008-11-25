require 'test_helper'

class SpaltennamenAendernsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:spaltennamen_aenderns)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_spaltennamen_aendern
    assert_difference('SpaltennamenAendern.count') do
      post :create, :spaltennamen_aendern => { }
    end

    assert_redirected_to spaltennamen_aendern_path(assigns(:spaltennamen_aendern))
  end

  def test_should_show_spaltennamen_aendern
    get :show, :id => spaltennamen_aenderns(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => spaltennamen_aenderns(:one).id
    assert_response :success
  end

  def test_should_update_spaltennamen_aendern
    put :update, :id => spaltennamen_aenderns(:one).id, :spaltennamen_aendern => { }
    assert_redirected_to spaltennamen_aendern_path(assigns(:spaltennamen_aendern))
  end

  def test_should_destroy_spaltennamen_aendern
    assert_difference('SpaltennamenAendern.count', -1) do
      delete :destroy, :id => spaltennamen_aenderns(:one).id
    end

    assert_redirected_to spaltennamen_aenderns_path
  end
end
