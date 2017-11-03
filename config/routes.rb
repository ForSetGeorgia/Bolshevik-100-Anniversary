Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    post '/users', to: 'users#create'

    devise_for :users,
               controllers: {
                 confirmations: 'users/confirmations',
                 omniauth: 'users/omniauth',
                 passwords: 'users/passwords',
                 registrations: 'users/registrations',
                 sessions: 'users/sessions',
                 unlocks: 'users/unlocks'
               },
               path_names: {sign_in: 'login', sign_out: 'logout'},
               constraints: { format: :html }

    match '/admin', :to => 'admin#index', :as => :admin, :via => :get, constraints: { format: :html }
    namespace :admin do
      resources :users, constraints: { format: :html }
      resources :page_contents, constraints: { format: :html }
      resources :stories, constraints: { format: :html }
      resources :about_images, constraints: { format: :html }
    end

    root 'root#index', constraints: { format: :html }
    get '/stories' => 'root#stories', constraints: { format: :html }
    get '/stories/:id' => 'root#story_show', as: 'story_show', constraints: { format: :html }
    get '/about' => 'root#about', constraints: { format: :html }

    # handles /en/fake/path/whatever
    get '*path', to: redirect("/#{I18n.default_locale}")
  end

  # handles /
  get '', to: redirect("/#{I18n.default_locale}")

  # handles /not-a-locale/anything
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")


end
