class QuestionsController < ApplicationController
  def index
    
  end
  
  def new
    @question = Question.new
  end
  
  def create
    question = Question.new(params[:question])
    
    # asker information
    question.user_id = current_user.id
    question.username = current_user.username
    
    # UNIX Timestamp
    question.created_at = question.updated_at = Time.now.to_i
    
    # use redcarpet to render context
    question.markdown = Helper.markdown(question.content)
    
    # TODO: wait to use real UUID
    uuid = $redis.incr 'next.question.id'
    
    # serialize it into json
    serialized_data = MultiJson.encode(question.serializable_hash)
    
    # write into redis
    $redis.set("questions:#{uuid}", serialized_data)    
    
    redirect_to "/questions/#{uuid}"
  end
  
  def show
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
