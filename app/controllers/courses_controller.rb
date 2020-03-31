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
    erb :"/courses/new.html"
  end

  # POST: /courses
  post "/courses" do
    redirect "/courses"
  end

  # GET: /courses/5
  get "/courses/:id" do
    erb :"/courses/show.html"
  end

  # GET: /courses/5/edit
  get "/courses/:id/edit" do
    erb :"/courses/edit.html"
  end

  # PATCH: /courses/5
  patch "/courses/:id" do
    redirect "/courses/:id"
  end

  # DELETE: /courses/5/delete
  delete "/courses/:id/delete" do
    redirect "/courses"
  end
end
