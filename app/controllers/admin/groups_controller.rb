class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all.order("created_at DESC")
  end

  def show
    @group = Group.find(params[:id])
  end

  def all_destroy
    @group = Group.find(params[:group_id])
    if @group.destroy
      redirect_to admin_groups_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :comment)
  end

end