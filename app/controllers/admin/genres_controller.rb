class Admin::GenresController < ApplicationController
  def index
    @jenre = Jenre.new
    @jenres = Jenre.all
  end

  def edit
  end
end
