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
    @courses= Course.all.sort_by(&:name)
    @course_groups=CourseGroup.all.uniq.sort_by(&:name)
    erb :"/instructors/new.html"
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
        redirect to "/instructors/#{Helpers.current_user(session).slug}"
      else
        if @instructor.name==""
          flash[:message] = "Username can't be blank"
        elsif !EmailAddress.valid?(@instructor.email)
          flash[:message] = "Please add valid email address"
        elsif @instructor.password_digest==nil
          flash[:message] = "Password can't be blank"
        elsif
          @instructor.first_name==""
            flash[:message] = "First Name can't be blank"
        elsif
          @instructor.last_name==""
            flash[:message] = "Last Name can't be blank"
        else
          flash[:message] = "Account with this username or email already exist"
        end
        redirect to '/instructors/new'
      end
  end

  # GET: /instructors/5
  get "/instructors/:slug" do
      @instructor = Instructor.find_by_slug(params[:slug].to_s)
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
     else
       if @instructor.name==""
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
         flash[:message] = "Account with this username or email already exist"
       end
       redirect "/instructors/#{params[:slug]}/edit"
     end
  end

  # DELETE: /instructors/5/delete
  delete "/instructors/:slug/delete" do
    @instructor = Instructor.find_by_slug(params[:slug].to_s)
    if !Course.any? { |e| e.creator_id==@instructor.id }
    @instructor.delete
    redirect "/logout"
    else
      flash[:message] = "Can't delete Instructor, need to delete courses first"
      redirect "/instructors/#{@instructor.slug}"
    end
  end

  get "/instructors/:slug/delete_all_courses" do
    @instructor = Instructor.find_by_slug(params[:slug].to_s)
    if @instructor == Helpers.current_user(session)
      @instructor.courses.each {|course| course.delete}
    end
    redirect "/instructors/#{@instructor.slug}"
  end


end
