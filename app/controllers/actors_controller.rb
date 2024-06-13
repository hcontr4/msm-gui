class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)

    render({ :template => "actor_templates/show" })
  end

  def create
    @actor = Actor.new

    @actor.name = params.fetch("query_name")
    @actor.dob = params.fetch("query_dob")
    @actor.bio = params.fetch("query_bio")
    @actor.image = params.fetch("query_image")

    if @actor.valid?
      @actor.save
      redirect_to("/actors", { :alert => "actor creation succesful" })
    else
      edirect_to("/actors", { :alert => "actor creation unsuccesful" })
    end
  end

  def update
    id = params.fetch("path_id")
    @actor = Actor.where({ :id => id }).first

    @actor.name = params.fetch("query_name")
    @actor.dob = params.fetch("query_dob")
    @actor.bio = params.fetch("query_bio")
    @actor.image = params.fetch("query_image")

    if @actor.valid?
      @actor.save
      redirect_to("/actors/#{id}", { :alert => "actor update succesful" })
    else
      redirect_to("/actors/#{id}", { :alert => "actor update unsuccesful" })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @actor = Actor.where({ :id => the_id }).first

    @actor.destroy
    redirect_to("/actors", { :alert => "actor deleted" })
  end
end
