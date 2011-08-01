class Bravia::API < Grape::API
  prefix 'api'

  resource 'questions' do
    get do
      Question.all
    end
        
    get ':id' do
      $redis.get("questions:#{params[:id]}")
    end
  end
end