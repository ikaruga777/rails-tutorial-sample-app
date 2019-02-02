resource "heroku_app" "staging" {
  name = "uvb76-rails-tutorial-staging"
  region = "us"
  # Create a database, and configure the app to use it
}

resource "heroku_addon" "postgres" {
  app  = "${heroku_app.staging.name}"
  plan = "heroku-postgresql:hobby-dev"
}
resource "heroku_addon" "pepatrail" {
  app  = "${heroku_app.staging.name}"
  plan = "papertrail:choklad"
}
resource "heroku_addon" "sendgrid" {
  app  = "${heroku_app.staging.name}"
  plan = "sendgrid:starter"
}



# Create a Heroku pipeline
resource "heroku_pipeline" "uvb76-rails-tutorial" {
  name = "uvb76-rails-tutorial"
}

# Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "staging" {
  app      = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.uvb76-rails-tutorial.id}"
  stage    = "staging"
}
