require
  shim:
    'libs/bootstrap': deps: ['libs/jquery']
    'libs/angular': deps: ['libs/bootstrap']
    'app': deps: [
      'libs/angular'
    ]
    'bootstrap': deps: ['app']
    'views': deps: ['app']
    'controllers/main':
      deps: [
        'app'
      ]
  [
    'require'
    'controllers/main'
    'libs/firebase'
    'views'
  ], (require) ->
    require ['bootstrap']