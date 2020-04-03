class InstructorsController < ApplicationController


  # GET: /instructors
  get "/instructors" do
    if Helpers.logged_in?(session)
      @instructor= Helpers.current_user(session)
    end
    @instructors=Instructor.all.sort_by(&:last_name)
    erb :"/instructors/index.html"
  end

  # GET: /instructors/new
  get "/instructors/new" do
    if !Helpers.logged_in?(session)
      @courses= Course.all.sort_by(&:name)
      @course_groups=CourseGroup.all.sort_by(&:name)
      erb :"/instructors/new.html"
    else
      @instructor= Helpers.current_user(session)
      redirect "/instructors/#{@instructor.slug}"
    end
  end

  # POST: /instructors
  post "/instructors" do
    @instructor=Instructor.new(params[:instructor])
      if EmailAddress.valid?(@instructor.email) && @instructor.save
        session[:user_id] = @instructor.id
        if !params[:course][:name].empty?
            @course = Course.new(params[:course])
            if !params[:course_group_name].empty?
              new_course_group = CourseGroup.create(name: params[:course_group_name], creator_id: @instructor.id)
                @course.course_group_id = new_course_group.id
            end
          @course.instructors << @instructor
          @course.creator_id=@instructor.id
          @course.save
        end
        redirect to "/instructors/#{@instructor.slug}"
        #redirect to "/instructors/#{Helpers.current_user(session).slug}"
      elsif !EmailAddress.valid?(@instructor.email)
          flash[:message] = "Please add valid email address"
      elsif @instructor.name==""
          flash[:message] = "Username can't be blank"
      elsif @instructor.password_digest==nil
          flash[:message] = "Password can't be blank"
      elsif @instructor.first_name==""
            flash[:message] = "First Name can't be blank"
      elsif @instructor.last_name==""
            flash[:message] = "Last Name can't be blank"
      else
          flash[:message] = "Account with this username or email already exists"
      end
        redirect '/instructors/new'
  end

  # GET: /instructors/5
  get "/instructors/:slug" do
      @instructor = Instructor.find_by_slug(params[:slug].to_s)
      @course_groups=CourseGroup.all.sort_by(&:name)
      @created_course_groups=@course_groups.select { |e| e.creator_id==@instructor.id  }
      @instructor_course_groups=@instructor.course_groups.uniq.sort_by(&:name)
      @instructor_courses=@instructor.courses.sort_by(&:name)
      erb :"/instructors/show.html"
  end

  # GET: /instructors/5/edit
  get "/instructors/:slug/edit" do
    @instructor = Instructor.find_by_slug(params[:slug].to_s)
    if Helpers.current_user(session) == @instructor
      @courses = Course.all.sort_by(&:name)
      erb :"/instructors/edit.html"
    else
      redirect to "/instructors/#{params[:slug]}"
    end
  end

  # PATCH: /instructors/5
  patch "/instructors/:slug" do
    @instructor = Instructor.find_by_slug(params[:slug])
      if  @instructor.update(params[:instructor]) && EmailAddress.valid?(@instructor.email)
        redirect "/instructors/#{@instructor.slug}"
      elsif @instructor.name==""
         flash[:message] = "Username can't be blank"
       elsif !EmailAddress.valid?(@instructor.email)
         flash[:message] = "Please add valid email address"
       elsif
         @instructor.first_name==""
           flash[:message] = "First Name can't be blank"
       elsif
         @instructor.last_name==""
           flash[:message] = "Last Name can't be blank"
       else
         flash[:message] = "Account with this username or email already exists"
       end
       redirect "/instructors/#{params[:slug]}/edit"
  end

  # DELETE: /instructors/5/delete
  delete "/instructors/:slug/delete" do
    @instructor = Instructor.find_by_slug(params[:slug].to_s)
    if !Course.any? { |e| e.creator_id==@instructor.id } || !CourseGroup.any? { |cg| cg.creator_id==@instructor.id }
    @instructor.delete
    redirect "/logout"
    else
      flash[:message] = "Can't delete Instructor, need to delete courses and course groups first"
      redirect "/instructors/#{@instructor.slug}"
    end
  end

  delete "/instructors/:slug/delete_all_courses" do
    @instructor = Instructor.find_by_slug(params[:slug].to_s)
    if @instructor == Helpers.current_user(session)
      @instructor.courses.each do |course|
        if course.creator_id == @instructor.id
          course.delete
        else
          @instructor.courses.delete(course)
        end
      end
    end
    redirect "/instructors/#{@instructor.slug}"
  end


end
