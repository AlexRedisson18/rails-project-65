# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @q = current_user.bulletins.order(created_at: :desc).ransack(params[:q])
    @aasm_states = Bulletin.aasm.states.map(&:name).map { |state| [t("bulletins.aasm_states.#{state}"), state] }

    @bulletins = @q.result.page(params[:page]).per(10)
  end
end
