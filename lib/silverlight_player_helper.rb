#Copyright (c) 2010 Bagwan Pankaj
#http://bagwanpankaj.com

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
  module SilverLightPlayerHelper
  
    #Defines default silverlight player options if none provided.
    #You can define DEFAULT_SILVERLIGHT_OPTIONS constants in your initializer to overrode options provided here.
    DEFAULT_SILVERLIGHT_OPTIONS = {
                                      :file         => '/others/video.wmv',
                                      :width        => '400',
                                      :height       => '300',
                                  } unless const_defined?('DEFAULT_SILVERLIGHT_OPTIONS')

    #Defines id and css for DOM element to be used for player and path to xaml file. DAEFAULT_PLAYER_CONFIG can also be   overridden by defining them in initializer
    DEFAULT_PLAYER_CONFIG = {
                              :player_id => 'silverlight_player',
                              :player_class => '',
                              :xaml_file => '/others/wmvplayer.xaml',
                              :player_message => 'The Player will be placed here.'
                             } unless const_defined?('DEFAULT_PLAYER_CONFIG')


    #Helper method available to all views.
    #Silverlight Player View Helper method.
    def silverlight_player(options = {}, player_config={})
      jw_player_config = DEFAULT_PLAYER_CONFIG.merge(player_config)
      player_options = DEFAULT_SILVERLIGHT_OPTIONS.merge(options)
      
      container = content_tag('div', jw_player_config[:player_message] , :id => jw_player_config[:player_id], :class => jw_player_config[:player_class])
      container << javascript_tag(build_js(jw_player_config, player_options))
    end

    private
    
    def buid_javascript(jw_player_config, player_options)
      %{
        var elm = document.getElementById("#{jw_player_config[:player_id]}");
        var src = '#{jw_player_config[:xaml_file]}';
        var cfg = #{get_config(player_options)};
        var ply = new jeroenwijering.Player(elm,src,cfg);
      }
    end
    alias_method :build_js, :buid_javascript
    
    #TODO find some good implementation.
    def get_config(player_options)
      result = player_options.collect { |key,value| "#{key.to_s} : '#{value.to_s}'" }.join(', ')
      "{#{result}}"
    end
  end
end

