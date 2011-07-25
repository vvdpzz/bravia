class Bravia::API < Grape::API
  prefix 'api'

  resource 'projects' do
    get do
      Project.all
    end

    get ':id' do
      $redis.get params[:id]
    end
  end

end