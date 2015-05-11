class LogicNodesController < ApplicationController
  def index
    @nodes = LogicNodes.all
  
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @node = $redis.get('aa')
  
    respond_to do |format|
      format.html # show.html.erb
    end
  end
end
