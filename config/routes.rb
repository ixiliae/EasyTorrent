# config/routes.rb

Rails.application.routes.draw do
  # La page d'accueil avec le formulaire de recherche
  root 'movies#search'

  # Route pour recevoir la recherche et afficher les résultats IMDB
  post 'display_imdb_results', to: 'movies#display_imdb_results'

  # Route pour recevoir l'ID IMDB choisi et chercher sur YTS
  post 'search_yts', to: 'movies#search_yts'

  # Route pour recevoir le film YTS choisi et afficher les torrents
  get 'display_torrents', to: 'movies#display_torrents'
  post 'display_torrents', to: 'movies#display_torrents'

  # Route finale pour ajouter le magnet au client torrent
  post 'add_torrent', to: 'movies#add_torrent'
end