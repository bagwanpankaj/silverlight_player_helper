module RailsJaipur
  module SLPlayerHelper
    DEFAULT_SILVER_OPTIONS = {
                                :file         => '/others/video.wmv',
                                :width        => '400',
                                :height       => '300',
                            } unless const_defined?('DEFAULT_SILVER_OPTIONS')

    DAEFAULT_PLAYER_CONFIG = {
                              :player_id => 'silverlight_player',
                              :xaml_file => '/others/wmvplayer.xaml'
                             } unless const_defined?('DAEFAULT_PLAYER_CONFIG')

    DEFAULT_MESSAGE = "The player will be placed here."

    def jw_silverlight_player(options = {}, player_config={})
      jw_player_config = DAEFAULT_PLAYER_CONFIG.merge(player_config)
      player_options = DEFAULT_SILVER_OPTIONS.merge(options)
      get_config(player_options)
      container = "<div id=\"#{jw_player_config[:player_id]}\">The player will be placed here</div>"
      string = container
      string << %{<script type='text/javascript'>
          var elm = document.getElementById("#{jw_player_config[:player_id]}");
          var src = '#{jw_player_config[:xaml_file]}';
          var cfg = #{get_config(player_options)};
          var ply = new jeroenwijering.Player(elm,src,cfg);
      </script>}
      string
    end

    private
    def get_config(player_options)
      res = "{"
      player_options.each do |key, value|
        res << "#{key} : '#{value}',"
      end
      res << "}"
      res
    end
  end
end