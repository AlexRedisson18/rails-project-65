# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class HomeControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @admin = users(:two)
      end

      test 'should get index' do
        sign_in @admin

        get admin_root_url

        assert_response :success
      end

      test 'should NOT get index' do
        sign_in @user

        get admin_root_url

        assert_redirected_to root_path
      end
    end
  end
end
