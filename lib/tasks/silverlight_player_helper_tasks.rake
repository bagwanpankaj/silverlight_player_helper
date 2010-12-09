namespace :sl_player do

  PLUGIN_ROOT = File.dirname(__FILE__) + '/../../'

  desc "Installs required files"
  task :install do
    FileUtils.cp_r Dir[PLUGIN_ROOT + '/assets/others'], ::Rails.root.to_s + '/public'
    FileUtils.cp Dir[PLUGIN_ROOT + '/assets/javascripts/*.js'], ::Rails.root.to_s + '/public/javascripts'
  end

  desc "Uninstalls files required by Silverlight Player"
  task :remove do
    FileUtils.rm_rf ::Rails.root.to_s + '/public/others'
    FileUtils.rm_f %w{silverlight.js wmvplayer.js}.collect { |file| ::Rails.root.to_s + "/public/javascripts/" + file  }
  end
end
