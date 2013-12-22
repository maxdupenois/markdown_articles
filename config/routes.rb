Marti::Engine.routes.draw do
  root to: "articles#index"
  get '/:path' => "articles#show", as: :article
end
