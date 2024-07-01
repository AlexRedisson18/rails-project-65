# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @admin = users(:two)

        @category = categories(:one)
        @params = { name: 'Category name' }
      end

      test 'should get index' do
        sign_in @admin

        get admin_categories_url

        assert_response :success
      end

      test 'should NOT get index' do
        sign_in @user

        get admin_categories_url

        assert_redirected_to root_path
      end

      test 'should get new' do
        sign_in @admin

        get new_admin_category_url

        assert_response :success
      end

      test 'should NOT get new' do
        sign_in @user

        get new_admin_category_url

        assert_redirected_to root_path
      end

      test 'should create category' do
        sign_in @admin

        post admin_categories_url, params: { category: @params }

        assert Category.find_by(name: @params[:name])
      end

      test 'should NOT create category' do
        sign_in @user

        post admin_categories_url, params: { category: @params }

        assert_redirected_to root_path
      end

      test 'should get edit' do
        sign_in @admin

        get edit_admin_category_url(@category)

        assert_response :success
      end

      test 'should NOT get edit' do
        sign_in @user

        get edit_admin_category_url(@category)

        assert_redirected_to root_path
      end

      test 'should update category' do
        sign_in @admin

        new_name = 'New category name'
        new_params = @params.merge(name: new_name)

        patch admin_category_path(@category), params: { category: new_params }

        assert Category.find_by(name: new_name)
      end

      test 'should NOT update category' do
        sign_in @user

        new_name = 'New category name'
        new_params = @params.merge(name: new_name)

        patch admin_category_path(@category), params: { category: new_params }

        assert_redirected_to root_path
      end

      test 'should destroy category' do
        sign_in @admin

        empty_category = Category.create(name: 'Empty category')

        delete admin_category_url(empty_category)

        assert_not Category.find_by(name: empty_category.name)
      end

      test 'should NOT destroy category' do
        sign_in @user

        empty_category = Category.create(name: 'Empty category')

        delete admin_category_url(empty_category)

        assert_redirected_to root_path
      end
    end
  end
end
