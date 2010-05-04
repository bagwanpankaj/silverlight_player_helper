#Copyright (c) 2010 Bagwan Pankaj

#Permission is hereby granted, free of charge, to any person obtaining
#a copy of this software and associated documentation files (the
#"Software"), to deal in the Software without restriction, including
#without limitation the rights to use, copy, modify, merge, publish,
#distribute, sublicense, and/or sell copies of the Software, and to
#permit persons to whom the Software is furnished to do so, subject to
#the following conditions:

#The above copyright notice and this permission notice shall be
#included in all copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module RailsJaipur
  module SLPlayerHelper
  
    #Defines default silverlight player options if none provided.
    #You can define DEFAULT_SILVER_OPTIONS constants in your initializer to overrode options provided here.
    DEFAULT_SILVER_OPTIONS = {
                                :file         => '/others/video.wmv',
                                :width        => '400',
                                :height       => '300',
                            } unless const_defined?('DEFAULT_SILVER_OPTIONS')

    #Defines id for DOM element to be used for player and path to xaml file. DAEFAULT_PLAYER_CONFIG can also be          overridden by defining them in initializer
    DAEFAULT_PLAYER_CONFIG = {
                              :player_id => 'silverlight_player',
                              :xaml_file => '/others/wmvplayer.xaml'
                             } unless const_defined?('DAEFAULT_PLAYER_CONFIG')

    #This message will be displayed instead of player if something goes wrong with initialization 
    DEFAULT_MESSAGE = "The player will be placed here."

    #Helper method available to all views.
    def jw_silverlight_player(options = {}, player_config={})
      jw_player_config = DAEFAULT_PLAYER_CONFIG.merge(player_config)
      player_options = DEFAULT_SILVER_OPTIONS.merge(options)
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
