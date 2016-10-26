Rails.application.routes.draw do
  # this means when we receive a GET request with `/` url we invoke the index
  # action within the Home Controller
  root 'home#index'

  resources :users, only: [:create, :new]
  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection #if it's 'on collection', it skips having an id of any sort in the URL, for security, we can destroy session like this 
  end

  #the url helpers, when we set them using 'as' , are only concerned about the
  #URL and not the CERB , so even if we have two routes with the same URL and
  #different verbs, the url helper
  # should be the same
  # get({'/questions/new' => 'questions#new', as: :new_question})
  # post({'/questions'    => 'questions#create', as: :questions})
  # get '/questions/:id'  => 'questions#show', as: :question
  # get 'questions'       => 'questions#index'
  # get '/questions/:id/edit' => 'questions#edit', as: :edit_question
  # patch '/questions/:id' => 'questions#update' #questions/:id is alrady there so you don't need to specify an 'as: '
  # delete '/questions/:id' => 'questions#destroy' #as not needed , already defined
  #
resources :questions, shallow: true do
  get :search, on: :collection
  get :flag, on: :member
  post :approve
  # nesting the answers resources within the questions resources block
# will make it so that every `answers` route is prefixed with:
# `/questions/:question_id`. We will need the `question_id` to create
# an answer associated with a question so we will stick with this way of
# defining the routes. The routes helpers will also have `question_` prefix
  resources :answers, on: [:create, :destroy]do
      resources :comments, only: [:create, :destroy]
    end
end


  get '/contact' => 'home#contact' # Rails auto-generate a URL helper called
                                   # contact_path (and contact_url)

  post '/contact_submit' => 'home#contact_submit'
end
