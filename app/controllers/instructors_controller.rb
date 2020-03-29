class InstructorsController < ApplicationController


  # GET: /instructors
  get "/instructors" do
    @instructors=Instructor.all.sort_by(&:last_name)
    erb :"/instructors/index.html"
  end

  # GET: /instructors/new
  get "/instructors/new" do
    erb :"/instructors/new.html"
  end

  # POST: /instructors
  post "/instructors" do
      @instructor=Instructor.new(params)
      if EmailAddress.valid?(params[:email]) && @instructor.save
        session[:user_id] = @instructor.id
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
  get "/instructors/:id/edit" do
    erb :"/instructors/edit.html"
  end

  # PATCH: /instructors/5
  patch "/instructors/:id" do
    redirect "/instructors/:id"
  end

  # DELETE: /instructors/5/delete
  delete "/instructors/:id/delete" do
    redirect "/instructors"
  end


end
