class CourseGroupsController < ApplicationController

  # GET: /course_groups
  get "/course_groups" do
    erb :"/course_groups/index.html"
  end

  # GET: /course_groups/new
  get "/course_groups/new" do
    erb :"/course_groups/new.html"
  end

  # POST: /course_groups
  post "/course_groups" do
    redirect "/course_groups"
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
