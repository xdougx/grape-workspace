module API
  class Hello < Grape::API
    version 'v1', using: :path

    helpers do
      def redaction_params
        ActionController::Parameters.new(params).require(:redaction).permit(:subject, :body, :owner_name)
      end
    end

    resource :redactions do
      post "/create" do
        Redaction.build(redaction_params)
      end

      get "/find/:id" do
        Redaction.find(params[:id])
      end
    end

    resource :greet do
      get "/hello" do
        name = params.join(" ")
        user = User.new
        user.greet name
      end

      get "/congrat" do
        name = params.map {|k, v| v.capitalize }.join(" ")
        user = User.new
        user.congrat name
      end
    end
  end
end


