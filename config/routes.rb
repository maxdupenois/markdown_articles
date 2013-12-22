Marti::Engine.routes.draw do
  root to: "marticles#index"
  get '/:path' => "marticles#show", as: :marticle
end
