class GroupsController < ApplicationController
  def index 
    @groups = Group.all
  end

  def create 
    @group = Group.new
  end
end