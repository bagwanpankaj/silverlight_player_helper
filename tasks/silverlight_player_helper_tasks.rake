namespace :sl_player do

  desc "Installs required files"
  task :install do
    FileUtils.cp_r Dir[PLUGIN_ROOT + '/assets/others'], RAILS_ROOT + '/public'
    FileUtils.cp Dir[PLUGIN_ROOT + '/assets/javascripts/*.js'], RAILS_ROOT + '/public/javascripts'
  end

  desc "Uninstalls files required by Silverlight Player"
  task :remove do
    FileUtils.rmdir RAILS_ROOT + 'public/others'
    FileUtils.rm_f %{silverlight.js wmvplayer.js}.collect { |file| RAILS_ROOT + "/public/javascripts/" + file  }
  end
end
