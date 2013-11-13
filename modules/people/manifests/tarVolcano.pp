class people::tarVolcano {

  # local application for develop / Puppetfile で定義したもの
  include virtualbox
  include vagrant
  include iterm2::stable
  include sublime_text_2
  include chrome
  include dropbox
  include alfred

  # homebrew でインストールするもの
  package {
    [
      'tree',
    ]:
  }
  
  package {
    'Kobito':
      source   => "http://kobito.qiita.com/download/Kobito_v1.8.3.zip",
      provider => compressed_app;
    'onepassword':
      source   => "https://d13itkw33a7sus.cloudfront.net/dist/1P/mac4/1Password-4.0.9.zip",
      provider => compressed_app;
  }
  
  # vagrantプラグイン
  vagrant::plugin {
    [
      'vagrant-berkshelf',
      'vagrant-omnibus',
    ]:
  }
  
  # Sublime text2プラグイン
  sublime_text_2::package {
    'ConvertToUTF8':
      source => 'seanliang/ConvertToUTF8';
    'LineEndings':
      source => 'SublimeText/LineEndings';
    'Markdown Preview':
      source => 'revolunet/sublimetext-markdown-preview';
    'VBScript':
      source => 'SublimeText/VBScript';
    ##'Package Control':
    ##　source => 'wbond/sublime_package_control';
    ##　source => 'wbond/sublime_alignment';
    ##↑どっちもうまく入らない、ソースが違うのかな？以下エラーメッセージ
    ##Wrapped exception:
    ##Could not match 　source
    ##Error: Could not match 　source at /opt/boxen/repo/modules/people/manifests/tarvolcano.pp:47 on node tars-mba.local

  
  }

  ###################
  # osxの設定(https://github.com/boxen/puppet-osx)
  ###################
  # +------- global --------+
  #include osx::global::enable_keyboard_control_access # ON :キーボードでのコントロール
  include osx::global::disable_autocorrect            # OFF:自動スペル補正
  include osx::global::key_repeat_delay               # Set the default value (35)
  #class { 'osx::global::key_repeat_delay':           # キーをおしっぱにして連続入力されるまでのdelay
  #  delay => 10                                      # を10ミリ秒に
  #}
  include osx::global::key_repeat_rate                # Set the default value (0)
  #class { 'osx::global::key_repeat_rate':            # キーを押しっぱなしにしてして連続入力される間隔
  #  rate => 5                                        # を5ミリ秒に
  #}


  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/.dotfiles"

  file { $home:
    ensure  => directory
  }

  ## ## git clone git@github.com:tarVolcano/dotfiles.git
  ##repository { $dotfiles:
  ##  source  => 'tarVolcano/dotfiles',
  ##  require => File[$home]
  ##}

  ## ## git-cloneしたら install.sh を走らせる
  ##exec { "sh ${dotfiles}/install.sh":
  ##  cwd => $dotfiles,
  ##  creates => "${home}/.zshrc",
  ##  require => Repository[$dotfiles],
  ##}
}

