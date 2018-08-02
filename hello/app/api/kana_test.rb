module API
  class KanaTest < Grape::API
    version 'v1', using: :path


    helpers do
      def test_params
        ActionController::Parameters.new(params).require(:version).permit(:version, :document_id, :file)
      end
    end

    resource :kanamobi do
      post "/create" do
        Document.create(params)
      end

      get "/new" do
        content_type "text/html"
        Template.new("new").build        
      end
    end
  end
end


