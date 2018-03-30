class Env {
  final _mode = EnvMode.Dev;

  get dev {
    return _mode == EnvMode.Dev;
  }

  get prod {
    return _mode == EnvMode.Prod;
  }

  get test {
    return _mode == EnvMode.Test;
  }

  get mode {
    return _mode;
  }
}

enum EnvMode { Dev, Test, Prod }
