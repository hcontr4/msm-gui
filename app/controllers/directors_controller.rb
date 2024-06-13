class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def create
    @director = Director.new

    @director.name = params.fetch("query_name")
    @director.dob = params.fetch("query_dob")
    @director.bio = params.fetch("query_bio")
    @director.image = params.fetch("query_image")

    if @director.valid?
      @director.save
      redirect_to("/directors", {:alert => "director added"})
    else
      redirect_to("/directors", {:alert => "director not added"})
    end
  end

  def update
    the_id = params.fetch("path_id")
    @director = Director.where({ :id => the_id}).first

    @director.name = params.fetch("query_name")
    @director.dob = params.fetch("query_dob")
    @director.bio = params.fetch("query_bio")
    @director.image = params.fetch("query_image")

    if true
      @director.save
      redirect_to("/directors/#{the_id}", {:alert => "update succesful"})
    else
      redirect_to("/directors/#{the_id}", {:alert => "update unsuccesful"})
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @director = Director.where({:id => the_id}).first

    @director.destroy
    redirect_to("/directors", {:alert => "deletion succesful"})
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
