module ApiV1
  class ScrobblesController < ApiController
    before_filter :expires_now

    def now_playing
      artist = params[:artist]
      title = params[:title]

      if user != nil && user.lastfm_session_key != nil
        Rails.logger.info 'Update Now Playing to "' + artist + ' - ' + title + '" for user ' + user.username

        track = Rockstar::Track.new(artist, title)
        track.updateNowPlaying(Time.now, user.lastfm_session_key)
      end

      render :nothing => true
    end

    def scrobble
      artist = params[:artist]
      title = params[:title]

      if user != nil && user.lastfm_session_key != nil
        Rails.logger.info 'Scrobbling track "' + artist + ' - ' + title + '" for user ' + user.username

        track = Rockstar::Track.new(artist, title)
        track.scrobble(Time.now, user.lastfm_session_key)
      end

      render :nothing => true
    end

    private

      def user
        @user ||= User.find(session[:user_id])
      end

  end
end