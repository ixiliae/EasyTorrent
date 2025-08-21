# app/controllers/movies_controller.rb

class MoviesController < ApplicationController
  require 'httparty'
  require 'nokogiri'

  # Action pour afficher le formulaire de recherche initial
  def search
  end

  # Action pour chercher sur IMDB et afficher les résultats
  def display_imdb_results
    movie_name = params[:movie_name]
    # Utilise une API de suggestion non officielle d'IMDB
    imdb_url = "https://v3.sg.media-imdb.com/suggestion/x/#{URI.encode_www_form_component(movie_name)}.json"
    response = HTTParty.get(imdb_url)
    @results = response.parsed_response['d'] || []

    render :display_imdb_results
  end

  # Action pour chercher le film sélectionné sur YTS
  def search_yts
    @imdb_id = params[:imdb_id]
    # L'API YTS officielle supporte la recherche par ID IMDB
    yts_url = "https://yts.mx/api/v2/list_movies.json?query_term=#{@imdb_id}"
    response = HTTParty.get(yts_url)
    @movies = response.parsed_response.dig('data', 'movies') || []

    render :display_yts_results
  end

  # Action pour afficher les torrents pour un film YTS
  def display_torrents
    yts_movie_url = params[:yts_movie_url]
    response = HTTParty.get(yts_movie_url)
    doc = Nokogiri::HTML(response.body)

    @movie_title = doc.css('div.movie-info div h1').text
    @torrents = doc.css('.modal-torrent').map do |torrent_div|
      {
        quality: torrent_div.css('.modal-quality').text.strip,
        size: torrent_div.css('p.quality-size').last.text.strip,
        magnet_url: torrent_div.css('a.magnet-download').attr('href').value
      }
    end

    render :display_torrents
  end

  # Action pour envoyer le magnet au client Torrent
  def add_torrent
    magnet_url = params[:magnet_url]
    transmission_url = TRANSMISSION_RPC_URL
    
    # Premier appel pour obtenir le session ID
    begin
      initial_response = HTTParty.post(transmission_url, headers: { 'Content-Type' => 'application/json' })
    rescue HTTParty::Error, SocketError => e
      flash[:error] = "Impossible de contacter le serveur de torrents : #{e.message}"
      redirect_to root_path and return
    end

    session_id = initial_response.headers['x-transmission-session-id']

    if initial_response.code == 409 && session_id
      payload = {
        method: "torrent-add",
        arguments: {
          filename: magnet_url,
          "download-dir": "/films",
          paused: false
        }
      }

      headers = {
        'Content-Type' => 'application/json',
        'X-Transmission-Session-Id' => session_id
      }

      # Deuxième appel avec le session ID
      response = HTTParty.post(
        transmission_url,
        body: payload.to_json,
        headers: headers
      )

      if response.success? && response.parsed_response['result'] == 'success'
        flash[:success] = "Le torrent a été ajouté avec succès !"
      else
        flash[:error] = "Erreur lors de l'ajout du torrent : #{response.parsed_response['result'] || response.message}"
      end
    else
      flash[:error] = "Impossible d'obtenir un ID de session valide du serveur de torrents."
    end

    redirect_to root_path
  end
end