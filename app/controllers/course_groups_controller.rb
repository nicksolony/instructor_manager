class CourseGroupsController < ApplicationController

  # GET: /course_groups
  get "/course_groups" do
    if Helpers.logged_in?(session)
      @instructor= Helpers.current_user(session)
    end
    @course_groups=CourseGroup.all.sort_by(&:name)
    erb :"/course_groups/index.html"
  end

  # GET: /course_groups/new
  get "/course_groups/new" do
    if Helpers.logged_in?(session)
      @instructor= Helpers.current_user(session)
      erb :"/course_groups/new.html"
    else
      redirect to '/course_groups'
    end

  end

  # POST: /course_groups
  post "/course_groups" do
    @instructor= Helpers.current_user(session)
    @course_group=CourseGroup.new(params[:course_group])
    @course_group.creator_id = @instructor.id
      if @course_group.save
        redirect to "/course_groups/#{@course_group.slug}"
      elsif @course_group.name==""
          flash[:message] = "Course Group Name can't be blank"
      else
          flash[:message] = "Course Group with this name already exists"
      end
        redirect to '/course_groups/new'
  end

  # GET: /course_groups/5
  get "/course_groups/:id" do
    erb :"/course_groups/show.html"
  end

  # GET: /course_groups/5/edit
  get "/course_groups/:id/edit" do
    erb :"/course_groups/edit.html"
  end

  # PATCH: /course_groups/5
  patch "/course_groups/:id" do
    redirect "/course_groups/:id"
  end

  # DELETE: /course_groups/5/delete
  delete "/course_groups/:id/delete" do
    redirect "/course_groups"
  end
end
