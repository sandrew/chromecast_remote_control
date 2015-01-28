set :linked_files, fetch(:linked_files, []) + %w{config/thin/production.yml}

server '82.146.40.106', user: 'gearhead', roles: %w{web app db}
