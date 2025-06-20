function fn() {
  var env = karate.env || 'dev';

  // Configuración base para todos los entornos
  var config = {
    baseUrl: 'http://localhost:8080'
  };

  // URLs para todos los microservicios (nombrados con formato port_nombre_microservicio)
  // Ejemplo: config.port_tu_microservicio = 'http://localhost:8081/tu-microservicio';
  config.port_marvel = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/ddalmach';

  // Configuración específica por entorno
  if (env == 'dev') {
    config.baseUrl = 'https://api-dev.empresa.com';
    config.port_marvel = 'https://bp-se-test-cabcd9b246a5.herokuapp.com/ddalmach';
  }
  else if (env == 'qa') {
    config.baseUrl = 'https://api-qa.empresa.com';
    config.port_marvel = 'https://bp-se-test-cabcd9b246a5.herokuapp.com/ddalmach';
  }

  return config;
}

