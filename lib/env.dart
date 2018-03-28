class Env {
  static final _mode = EnvMode.Dev;

  static get dev {
    return _mode == EnvMode.Dev;
  }

  static get prod {
    return _mode == EnvMode.Prod;
  }

  static get test {
    return _mode == EnvMode.Test;
  }

  static get mode {
    return _mode;
  }
}

enum EnvMode { Dev, Test, Prod }
