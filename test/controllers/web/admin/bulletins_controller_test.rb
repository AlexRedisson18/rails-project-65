# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @admin = users(:two)

        @bulletin_draft = bulletins(:draft)
        @bulletin_under_moderation = bulletins(:under_moderation)
      end

      def attach_file(bulletin)
        bulletin.image.attach(io: Rails.root.join('test/fixtures/files/image_0.jpg').open, filename: 'filename.jpg')
      end

      test 'should get index' do
        sign_in @admin

        get admin_bulletins_url

        assert_response :success
      end

      test 'should NOT get index' do
        sign_in @user

        get admin_bulletins_url

        assert_redirected_to root_path
      end

      test 'should publish bulletin' do
        sign_in @admin

        attach_file(@bulletin_under_moderation)

        patch publish_admin_bulletin_url(@bulletin_under_moderation)

        assert @bulletin_under_moderation.reload.published?
      end

      test 'should NOT publish bulletin' do
        sign_in @user

        attach_file(@bulletin_under_moderation)

        patch publish_admin_bulletin_url(@bulletin_under_moderation)

        assert_redirected_to root_path
      end

      test 'should reject bulletin' do
        sign_in @admin

        attach_file(@bulletin_under_moderation)

        patch reject_admin_bulletin_url(@bulletin_under_moderation)

        assert @bulletin_under_moderation.reload.rejected?
      end

      test 'should NOT reject bulletin' do
        sign_in @user

        attach_file(@bulletin_under_moderation)

        patch reject_admin_bulletin_url(@bulletin_under_moderation)

        assert_redirected_to root_path
      end

      test 'should archive bulletin' do
        sign_in @admin

        attach_file(@bulletin_draft)

        patch archive_admin_bulletin_url(@bulletin_draft)

        assert @bulletin_draft.reload.archived?
      end

      test 'should NOT archive bulletin' do
        sign_in @user

        attach_file(@bulletin_draft)

        patch archive_admin_bulletin_url(@bulletin_draft)

        assert_redirected_to root_path
      end
    end
  end
end
