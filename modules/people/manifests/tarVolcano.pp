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
  }   

  ###################
  # osxの設定(https://github.com/boxen/puppet-osx)
  ###################
  # +------- global --------+
  include osx::global::enable_keyboard_control_access # ON :キーボードでのコントロール
  include osx::global::disable_autocorrect            # OFF:自動スペル補正
  class { 'osx::global::key_repeat_delay':            # キーをおしっぱにして連続入力されるまでのdelay
    delay => 10                                       # を10ミリ秒に
  }
  class { 'osx::global::key_repeat_rate':             # キーを押しっぱなしにしてして連続入力される間隔
    rate => 2                                         # を2ミリ秒に
  }


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

