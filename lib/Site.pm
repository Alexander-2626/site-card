package Site;
use Mojo::Base 'Mojolicious', -signatures;
use utf8;
# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to(cb => sub {
    shift->render('index', layout => 'default', title => 'Искусственный интеллект для бизнеса');
  }); 
  $r->get('/example/welcome')->to('example#welcome');
}

1;
