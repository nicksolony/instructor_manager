class CoursesController < ApplicationController

  # GET: /courses
  get "/courses" do
    if Helpers.logged_in?(session)
      @instructor= Helpers.current_user(session)
      @instructor_courses=Course.select{|course| course.instructors.include?(@instructor)}
    end
    #@courses=Course.all.sort_by(&:name)
    @courses=Course.all.sort_by{|t| [t.course_group.name, t.name]}
    erb :"/courses/index.html"
  end


  # GET: /courses/new
  get "/courses/new" do
    if Helpers.logged_in?(session)
      @instructor= Helpers.current_user(session)
      @course_groups=CourseGroup.all.uniq.sort_by(&:name)
      erb :"/courses/new.html"
    else
      redirect to '/courses'
    end
  end

  # POST: /courses
  post "/courses" do
    @instructor= Helpers.current_user(session)
    @course=Course.new(params[:course])
    @course.instructors << @instructor
    @course.creator_id = @instructor.id
    if !params[:course_group_name].empty?
        new_course_group = CourseGroup.create(name: params[:course_group_name], creator_id: @instructor.id)
        @course.course_group_id = new_course_group.id
    end
      if @course.save
        redirect to "/courses/#{@course.slug}"
      elsif @course.name==""
          flash[:message] = "Course Name can't be blank"
      elsif CourseGroup.any? { |cg| cg.name==params[:course_group_name] }
          flash[:message] = "Course Group with this name already exists"
      else
          flash[:message] = "Course with this name already exists"
      end
        redirect to '/courses/new'
      end


  # GET: /courses/5
  get "/courses/:slug" do
      @course = Course.find_by_slug(params[:slug].to_s)
      @course_creator = Instructor.find(@course.creator_id)
      @instructors= @course.instructors.sort_by{|t| [t.last_name, t.first_name]}
      erb :"/courses/show.html"
  end

  # GET: /courses/5/edit
  get "/courses/:slug/edit" do
    @course = Course.find_by_slug(params[:slug].to_s)
    @course_creator = Instructor.find(@course.creator_id)
    @instructors= @course.instructors.sort_by{|t| [t.last_name, t.first_name]}
    @course_groups=CourseGroup.all.sort_by(&:name)
    if Helpers.current_user(session) == @course_creator
      erb :"/courses/edit.html"
    else
      redirect to "/courses/#{params[:slug]}"
    end
  end

  # PATCH: /courses/5
  patch "/courses/:slug" do
    @course = Course.find_by_slug(params[:slug])
     if  @course.update(params[:course])
       if !params[:course_group_name].empty?
           new_course_group = CourseGroup.create(name: params[:course_group_name], creator_id: Helpers.current_user(session).id)
           @course.course_group_id = new_course_group.id
           @course.save
       end
       redirect "/courses/#{@course.slug}"
     elsif @course.name==""
         flash[:message] = "Course Name can't be blank"
     else
         flash[:message] = "Course with this name already exists"
     end
       redirect "/courses/#{params[:slug]}/edit"
    end



  # DELETE: /courses/5/delete
  delete "/courses/:slug/delete" do
    @course = Course.find_by_slug(params[:slug].to_s)
    @course.delete
    redirect "/instructors/#{Helpers.current_user(session).slug}"
  end

end
