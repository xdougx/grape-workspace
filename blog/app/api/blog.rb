module API
  class Blog < Grape::API
    version 'blog', using: :path

    helpers StatusHelpers

    helpers do
      def redaction_params
        ActionController::Parameters.new(params).require(:redaction).permit(:subject, :body, :author, :tags)
      end

      def render

      end
    end

    resource :articles do
      post "/create" do
        content_type "text/html"
        @redaction = Redaction.build(redaction_params)
        Template.new("home/show").build
      end

      get "/:id" do
        content_type "text/html"
        @redaction = Redaction.find_by_permalink(params[:id])
        Template.new("home/show").build
      end

      get "/" do
        content_type "text/html"
        Template.new("home/home").build
      end
    end

  end
end


