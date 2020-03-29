class InstructorsController < ApplicationController

  # GET: /instructors
  get "/instructors" do
    erb :"/instructors/index.html"
  end

  # GET: /instructors/new
  get "/instructors/new" do
    erb :"/instructors/new.html"
  end

  # POST: /instructors
  post "/instructors" do
    redirect "/instructors"
  end

  # GET: /instructors/5
  get "/instructors/:id" do
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
