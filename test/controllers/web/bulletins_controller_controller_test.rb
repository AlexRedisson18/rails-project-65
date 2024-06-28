# frozen_string_literal: true

require 'test_helper'

module Web
  class BullertinControllerTest < ActionDispatch::IntegrationTest
    setup do
      @bulletin_published = bulletins(:published)
      @bulletin_draft = bulletins(:draft)

      @user = users(:one)
      @admin = users(:two)
      @category = categories(:one)

      image_path = Rails.root.join('test/fixtures/files/image_0.jpg')
      @image = Rack::Test::UploadedFile.new(image_path, 'image/jpeg')

      @params = {
        title: 'Bulletin title',
        description: 'Some bulletin description',
        category_id: @category.id,
        image: @image
      }
    end

    test 'should get index' do
      get bulletins_path
      assert_response :success
    end

    test 'should get new' do
      sign_in @user

      get new_bulletin_url
      assert_response :success
    end

    test 'should create bulletin' do
      sign_in @user

      post bulletins_url, params: { bulletin: @params }

      assert Bulletin.find_by(title: @params[:title])
    end

    test 'should show bulletin' do
      sign_in @admin

      get bulletin_url(@bulletin_published)

      assert_response :success
    end

    test 'should get edit' do
      sign_in @user

      get edit_bulletin_url(@bulletin_published)

      assert_response :success
    end

    test 'should update bulletin' do
      sign_in @user

      new_title = 'New title'
      new_params = @params.merge(title: new_title)

      patch bulletin_url(@bulletin_published), params: { bulletin: new_params }

      assert Bulletin.find_by(title: new_title)
    end

    test 'should to_moderate bulletin' do
      sign_in @user

      attach_file(@bulletin_draft)

      patch to_moderate_bulletin_url(@bulletin_draft)

      assert @bulletin_draft.reload.under_moderation?
    end

    test 'should archive bulletin' do
      sign_in @user

      attach_file(@bulletin_published)

      patch archive_bulletin_url(@bulletin_published)

      assert @bulletin_published.reload.archived?
    end

    def attach_file(bulletin)
      bulletin.image.attach(io: Rails.root.join('test/fixtures/files/image_0.jpg').open, filename: 'filename.jpg')
    end
  end
end
