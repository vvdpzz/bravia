class QuestionsController < ApplicationController
  def index
    
  end
  
  def new
    @question = Question.new
  end
  
  def create
    question = Question.new(params[:question])
    question.markdown = Helper.markdown(question.content)
    uuid = UUIDTools::UUID.random_create.to_s.gsub('-','').hex
    question.id = uuid
    $redis.set("questions:#{uuid}", question.to_json)
    redirect_to "/questions/#{uuid}"
  end
  
  def show
    @question = $redis.get("questions:#{params[:id]}")
    @question = JSON.parse(@question)
    puts @question[:markdown]
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
