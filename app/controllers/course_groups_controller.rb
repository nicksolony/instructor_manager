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
  get "/course_groups/:slug" do
    @course_group = CourseGroup.find_by_slug(params[:slug].to_s)
    @course_group_creator = Instructor.find(@course_group.creator_id)
    @instructors= @course_group.instructors.uniq.sort_by{|t| [t.last_name, t.first_name]}
    @course_group_courses = @course_group.courses.sort_by(&:name)
    erb :"/course_groups/show.html"
  end

  # GET: /course_groups/5/edit
  get "/course_groups/:slug/edit" do
    @course_group = CourseGroup.find_by_slug(params[:slug].to_s)
    @course_group_creator = Instructor.find(@course_group.creator_id)
    @instructors= @course_group.instructors.sort_by{|t| [t.last_name, t.first_name]}
    @course_group_courses = @course_group.courses.sort_by(&:name)
    if Helpers.current_user(session) == @course_group_creator
      erb :"/course_groups/edit.html"
    else
      redirect to "/course_group/#{params[:slug]}"
    end
  end

  # PATCH: /course_groups/5
  patch "/course_groups/:slug" do
    @course_group = CourseGroup.find_by_slug(params[:slug])
    @course_group_creator = Instructor.find(@course_group.creator_id)
     if  @course_group.update(params[:course_group])
       redirect "/course_groups/#{@course_group.slug}"
     elsif @course_group.name==""
         flash[:message] = "Course Name can't be blank"
     else
         flash[:message] = "Course with this name already exists"
     end
       redirect "/courses/#{params[:slug]}/edit"
  end

  # DELETE: /course_groups/5/delete
  delete "/course_groups/:slug/delete" do

    @course_group = CourseGroup.find_by_slug(params[:slug].to_s)
    if !Course.any? { |e| e.course_group==@course_group }
    @course_group.delete
    redirect "/course_groups"
    else
      flash[:message] = "Can't delete Course Group, need to delete courses first"
      redirect "/course_groups/#{@course_group.slug}"
    end
  end
end
