class AnswersController < ApplicationController
  
  def new
    @question = Question.find params[:question_id]
    @answer = @question.answers.build
  end
  
  def create
    question_id = params[:question_id]
    answer = Answer.new(params[:answer])
    
    # answer information
    answer.user_id = current_user.id
    answer.username = current_user.username
    
    # UNIX Timestamp
    answer.created_at = answer.updated_at = Time.now.to_i
    
    # use redcarpet to render context
    answer.markdown = Helper.markdown(answer.content)
    
   # TODO: wait to use real UUID
    uuid = $redis.incr 'next.answer.id'

    # serialize it into json
    serialized_data = MultiJson.encode(answer.serializable_hash)

    # write into redis
    $redis.sadd("answer_ids:#{question_id}", uuid)
    $redis.set("answer:#{uuid}", serialized_data)

    redirect_to "/answers/#{uuid}"
  end
end
